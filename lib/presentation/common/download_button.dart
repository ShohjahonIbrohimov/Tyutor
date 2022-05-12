import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:moreinfo/l10n/app_localization.dart';
// import 'package:moreinfo/data/providers/config.dart';
import 'package:moreinfo/presentation/common/button.dart';
import 'package:moreinfo/presentation/common/loader.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const String internalStorage = '/storage/emulated/0/Tyutor';

class DownloadButton extends StatefulWidget {
  String? url;
  String? title;

  DownloadButton({
    Key? key,
    required this.url,
    this.title = 'Topshiriqni yuklab olish',
  }) : super(key: key);

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  double progress = 0;
  bool loading = false;

  Future<bool> saveFile(String url) async {
    setState(() {
      loading = true;
    });
    String fileName = url.substring(url.lastIndexOf('/') + 1);
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.manageExternalStorage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          List<String> paths = directory!.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          directory = Directory(internalStorage);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/$fileName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await Dio().download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
          setState(() {
            progress = value1 / value2;
          });
        });

        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        setState(() {
          loading = false;
          progress = 0;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalization.of(context)!.translate('files_saved')),
              backgroundColor: green),
        );
        return true;
      }
      return false;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: red),
      );
      setState(() {
        loading = false;
        progress = 0;
      });
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AppButton(
      loading: loading,
      press: widget.url == null || widget.url!.isEmpty
          ? null
          : () {
              saveFile(widget.url!);
            },
      text:
          '${widget.title} ${progress > 0 ? '${(progress != 1 ? progress * 100 : progress).toStringAsFixed(0)}%' : ''}',
      icon: Icons.file_download_outlined,
    );
  }
}

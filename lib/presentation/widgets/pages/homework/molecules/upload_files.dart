import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/common/button.dart';

class UploadFiles extends StatefulWidget {
  Function(FilePickerResult?) handleFilesUpload;
  List fileNames = [];
  UploadFiles({
    Key? key,
    required this.handleFilesUpload,
    required this.fileNames,
  }) : super(key: key);

  @override
  State<UploadFiles> createState() => _UploadFilesState();
}

class _UploadFilesState extends State<UploadFiles> {
  void _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'xlsx', 'docx'],
        allowMultiple: true,
        onFileLoading: (FilePickerStatus status) => print(status),
      );
      if (result != null) {
        widget.handleFilesUpload(result);
      } else {
        // User canceled the picker
      }
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...widget.fileNames
            .map((e) => Container(
                  child: Text(
                    e,
                    style: TextStyle(color: Colors.blue.shade400),
                  ),
                  margin: EdgeInsets.only(bottom: 10),
                ))
            .toList(),
        const SizedBox(height: 15),
        AppButton(
          press: () {
            _pickFiles();
          },
          text: AppLocalization.of(context)!.translate('upload_report'),
          icon: Icons.file_upload_outlined,
        ),
      ],
    );
  }
}

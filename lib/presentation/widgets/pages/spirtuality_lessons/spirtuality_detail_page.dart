import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moreinfo/bloc/homework/homework_bloc.dart';
import 'package:moreinfo/bloc/task_upload/taskupload_bloc.dart';
import 'package:moreinfo/cubit/task/task_cubit.dart';
import 'package:moreinfo/data/models/homework/homework_model.dart';
import 'package:moreinfo/data/models/task_detail/task_detail_model.dart';
import 'package:moreinfo/data/providers/config.dart';
import 'package:moreinfo/presentation/common/app_container.dart';
import 'package:moreinfo/presentation/common/button.dart';
import 'package:moreinfo/presentation/common/error.dart';
import 'package:moreinfo/presentation/common/loader.dart';
import 'package:moreinfo/presentation/common/textfield.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:moreinfo/presentation/widgets/pages/homework/molecules/upload_files.dart';
import 'package:moreinfo/presentation/widgets/pages/homework/molecules/upload_image.dart';
import 'package:moreinfo/presentation/widgets/pages/students/molecules/filter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/src/provider.dart';

const description =
    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less The point of using Lorem Ipsum is that it has a more-or-less It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less The point of using Lorem Ipsum is that it has a more-or-less';

const String internalStorage = '/storage/emulated/0/Tyutor';

class HomeworkDetailPage extends StatefulWidget {
  const HomeworkDetailPage({Key? key}) : super(key: key);

  @override
  State<HomeworkDetailPage> createState() => _HomeworkDetailPageState();
}

class _HomeworkDetailPageState extends State<HomeworkDetailPage> {
  final _taskFormKey = GlobalKey<FormBuilderState>();
  File? _image;
  var _imagePath;
  List files = [];
  List fileNames = [];
  int? taskId;
  double progress = 0;
  String? downloadError;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int? id = context.read<TaskCubit>().state.id;
    context.read<HomeworkBloc>().add(StartFetchTask(id!));
    taskId = id;
  }

  void _handleImageUpload(XFile? image) {
    if (image != null) {
      setState(() {
        _image = File(image.path);
        _imagePath = image.path;
      });
    }
  }

  void _handleFilesUpload(FilePickerResult? result) {
    setState(() {
      files = result!.files;
      fileNames = result.names;
    });
  }

  Future<Map<String, dynamic>> _handleProcessTaskData() async {
    Map<String, dynamic> data = {};
    if (files.isNotEmpty && _imagePath.toString().isNotEmpty) {
      for (var i = 0; i < files.length; i++) {
        PlatformFile file = files[i];
        data['document_files[$i]'] = await MultipartFile.fromFile(file.path!);
      }
      data['image_files[0]'] = await MultipartFile.fromFile(_imagePath);
    }

    return data;
  }

  Future<bool> saveFile(String url) async {
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
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
          setState(() {
            progress = value1 / value2;
          });
        });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
      return false;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: red),
      );

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: BlocBuilder<HomeworkBloc, HomeworkState>(
                builder: (context, state) {
                  if (state is HomeworkSuccess) {
                    int status = state.taskData!.status;
                    return Icon(
                      Icons.circle,
                      color: status == 2 ? green : red,
                    );
                  }
                  return const Icon(
                    Icons.circle,
                    color: Colors.white,
                  );
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: AppContainer(child: BlocBuilder<HomeworkBloc, HomeworkState>(
            builder: (context, state) {
              if (state is HomeworkLoading) {
                return const Loading();
              } else if (state is HomeworkSuccess) {
                TaskDetailModel? task = state.taskData;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.school_outlined,
                          color: primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Sardor Bahodirovich",
                          style: TextStyle(
                            fontSize: 20,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 35),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(title: 'Dedlayn'),
                        const SizedBox(height: 10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(color: primaryColor),
                            children: <TextSpan>[
                              TextSpan(
                                text: task!.beginning_date,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: green,
                                  fontSize: 18,
                                ),
                              ),
                              const TextSpan(
                                text: ' - ',
                              ),
                              TextSpan(
                                text: task.deadline,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: red,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    FormBuilder(
                      // initialValue: {description: task.task_description},
                      key: _taskFormKey,
                      child: Column(
                        children: [
                          SectionTitle(title: 'Tyutorning izohi'),
                          const SizedBox(height: 10),
                          CommonTextField(
                            labelText: "izoh",
                            name: 'tyutor_description',
                          ),
                          const SizedBox(height: 25),
                          SectionTitle(title: 'Prorektor izohi'),
                          const SizedBox(height: 10),
                          Text(task.prorektor_description)
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    AppButton(
                      press: () {
                        saveFile(state.taskData!.taskFiles);
                      },
                      text:
                          'Topshiriqni yuklab olish ${progress > 0 ? '$progress%' : ''}',
                      icon: Icons.file_download_outlined,
                    ),
                    const SizedBox(height: 15),
                    SectionTitle(title: 'Xisobot'),
                    const SizedBox(height: 10),
                    UploadFiles(
                      fileNames: fileNames,
                      handleFilesUpload: _handleFilesUpload,
                    ),
                    const SizedBox(height: 15),
                    SectionTitle(title: 'Rasm'),
                    const SizedBox(height: 10),
                    UploadImage(
                        handleImageUpload: _handleImageUpload, image: _image),
                    const SizedBox(height: 80),
                    BlocListener<TaskUploadBloc, TaskUploadState>(
                      listener: (context, state) {
                        if (state is TaskUploadSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Vazifa muvaffaqiyatli yuklandi'),
                              backgroundColor: green,
                            ),
                          );
                        } else if (state is TaskUploadError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: red,
                            ),
                          );
                        }
                      },
                      child: Container(),
                    )
                  ],
                );
              } else if (state is HomeworkError) {
                return CustomError(text: state.message);
              }
              return Container();
            },
          )),
        ),
        floatingActionButton: AppContainer(
          child: BlocBuilder<TaskUploadBloc, TaskUploadState>(
            builder: (context, state) {
              return AppButton(
                loading: state is TaskUploadLoading,
                press: () async {
                  Map<String, dynamic> taskTobeSent =
                      await _handleProcessTaskData();
                  _taskFormKey.currentState!.save();
                  if (_taskFormKey.currentState!.validate()) {
                    context.read<TaskUploadBloc>().add(
                          StartUploadTask(
                            taskId: taskId!,
                            data: {
                              ...taskTobeSent,
                              ..._taskFormKey.currentState!.value
                            },
                          ),
                        );
                  }
                },
                text: 'Saqlash',
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  String title;
  SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.circle,
          color: primaryColorLight,
          size: 10,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}

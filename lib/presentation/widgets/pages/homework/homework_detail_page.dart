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
import 'package:moreinfo/cubit/user/user_cubit.dart';
import 'package:moreinfo/data/models/homework/homework_model.dart';
import 'package:moreinfo/data/models/task_detail/task_detail_model.dart';
import 'package:moreinfo/data/models/user/user_model.dart';
import 'package:moreinfo/data/providers/config.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/common/app_container.dart';
import 'package:moreinfo/presentation/common/button.dart';
import 'package:moreinfo/presentation/common/download_button.dart';
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

import 'molecules/status_icon.dart';

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
  String _imagePath = '';
  List files = [];
  List fileNames = [];
  int? taskId;
  double progress = 0;
  String? downloadError;
  UserModel? user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int? id = context.read<TaskCubit>().state.id;
    context.read<HomeworkBloc>().add(StartFetchTask(id!));
    taskId = id;
    user = context.read<UserCubit>().state;
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
      data['image_files[0]'] =
          await MultipartFile.fromFile(_imagePath.toString());
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalization.of(context)!.translate('homework')),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: BlocBuilder<HomeworkBloc, HomeworkState>(
                builder: (context, state) {
                  if (state is HomeworkSuccess) {
                    int status = state.taskData!.status;
                    return StatusIcon(status: status);
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
                return const Center(child: Loading());
              } else if (state is HomeworkSuccess) {
                TaskDetailModel? task = state.taskData;
                print(task);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.school_outlined,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          user?.fio ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      task!.task_description,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 35),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(
                            title: AppLocalization.of(context)!
                                .translate('_deadline')),
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
                          SectionTitle(
                              title: AppLocalization.of(context)!
                                  .translate('tutor_comment')),
                          const SizedBox(height: 10),
                          CommonTextField(
                            labelText: AppLocalization.of(context)!
                                .translate('comment'),
                            name: 'tyutor_description',
                          ),
                          const SizedBox(height: 25),
                          SectionTitle(
                              title: AppLocalization.of(context)!
                                  .translate('prorektor_comment')),
                          const SizedBox(height: 10),
                          Text(task.prorektor_description)
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    DownloadButton(
                      url: state.taskData!.taskFiles,
                      title: AppLocalization.of(context)!
                          .translate('download_task'),
                    ),
                    const SizedBox(height: 15),
                    SectionTitle(
                        title:
                            AppLocalization.of(context)!.translate('report')),
                    const SizedBox(height: 10),
                    UploadFiles(
                      fileNames: fileNames,
                      handleFilesUpload: _handleFilesUpload,
                    ),
                    const SizedBox(height: 15),
                    SectionTitle(
                        title: AppLocalization.of(context)!.translate('_pic')),
                    const SizedBox(height: 10),
                    UploadImage(
                        handleImageUpload: _handleImageUpload, image: _image),
                    const SizedBox(height: 80),
                    BlocListener<TaskUploadBloc, TaskUploadState>(
                      listener: (context, state) {
                        if (state is TaskUploadSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalization.of(context)!
                                  .translate('task_upload_success')),
                              backgroundColor: green,
                            ),
                          );
                          Navigator.pop(context);
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
                  if (_imagePath.isNotEmpty || fileNames.isNotEmpty) {
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
                  }
                },
                text: AppLocalization.of(context)!.translate('save'),
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

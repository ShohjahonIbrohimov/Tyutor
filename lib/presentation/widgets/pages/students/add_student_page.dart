import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:moreinfo/bloc/add_student/add_student_bloc.dart';
import 'package:moreinfo/bloc/student_info/student_info_bloc.dart';
import 'package:moreinfo/cubit/add_student/add_student_cubit.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/common/app_container.dart';
import 'package:moreinfo/presentation/common/button.dart';
import 'package:moreinfo/presentation/common/error.dart';
import 'package:moreinfo/presentation/common/loader.dart';
import 'package:moreinfo/presentation/widgets/pages/students/molecules/family_form.dart';
import 'package:moreinfo/presentation/widgets/pages/students/molecules/social_form.dart';
import 'package:moreinfo/presentation/widgets/pages/students/molecules/student_form.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormBuilderState>();
  List<Tab> tabs = [];
  bool isAdd = true;
  int? id;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isAdd = context.read<AddStudentCubit>().state.isAdd;
    id = context.read<AddStudentCubit>().state.id;
    if (!isAdd) context.read<StudentInfoBloc>().add(StartFetchStudent(id!));
    tabs = <Tab>[
      Tab(text: AppLocalization.of(context)!.translate('student')),
      Tab(text: AppLocalization.of(context)!.translate('social_status')),
      Tab(text: AppLocalization.of(context)!.translate('about_family')),
    ];
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalization.of(context)!.translate('about_student')),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            controller: _tabController,
            tabs: tabs,
          ),
        ),
        body: isAdd
            ? FormBuilder(
                key: _formKey,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: AppContainer(
                        child: StudentForm(
                          formKey: _formKey,
                          userImage: 'null',
                          isAdd: isAdd,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                        child: AppContainer(child: SocialForm())),
                    SingleChildScrollView(
                        child: AppContainer(child: FamilyForm())),
                  ],
                ),
              )
            : BlocBuilder<StudentInfoBloc, StudentInfoState>(
                builder: (context, state) {
                  if (state is StudentInfoLoadInProgress) {
                    return const Loading();
                  } else if (state is StudentInfoLoadSuccess) {
                    return FormBuilder(
                      initialValue: {...state.studentInfo!},
                      key: _formKey,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          SingleChildScrollView(
                              child: AppContainer(
                            child: StudentForm(
                              formKey: _formKey,
                              userImage: state.studentInfo!['image'],
                              isAdd: isAdd,
                            ),
                          )),
                          SingleChildScrollView(
                              child: AppContainer(child: SocialForm())),
                          SingleChildScrollView(
                              child: AppContainer(child: FamilyForm())),
                        ],
                      ),
                    );
                  } else if (state is StudentInfoLoadFailure) {
                    return CustomError(text: state.message);
                  }
                  return Container();
                },
              ),
        floatingActionButton: AppContainer(
          child: BlocBuilder<AddStudentBloc, AddStudentState>(
            builder: (context, state) {
              return AppButton(
                loading: state is AddStudentLoadInProgress,
                press: () {
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    if (_tabController.index == 2) {
                      if (isAdd) {
                        context
                            .read<AddStudentBloc>()
                            .add(StartAddStudent(_formKey.currentState!.value));
                      } else {
                        context.read<AddStudentBloc>().add(
                              StartUpdateStudent(
                                data: _formKey.currentState!.value,
                                studentId: id!,
                              ),
                            );
                      }
                    }
                    if (_tabController.index != 2) {
                      _tabController.animateTo((_tabController.index + 1) % 3);
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:moreinfo/bloc/student_info/student_info_bloc.dart';
import 'package:moreinfo/bloc/students/students_bloc.dart';
import 'package:moreinfo/cubit/add_student/add_student_cubit.dart';
import 'package:moreinfo/data/providers/private/students/get_talent_list.dart';
import 'package:moreinfo/data/repositories/student_info/student_info_repository.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/common/app_container.dart';
import 'package:moreinfo/presentation/common/button.dart';
import 'package:moreinfo/presentation/common/error.dart';
import 'package:moreinfo/presentation/common/loader.dart';
import 'package:moreinfo/presentation/common/section_divider.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import '../students/molecules/talented_student_form.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class AddTalentedStudentPage extends StatefulWidget {
  const AddTalentedStudentPage({Key? key}) : super(key: key);

  @override
  State<AddTalentedStudentPage> createState() => _AddTalentedStudentPageState();
}

var uuid = Uuid();

class _AddTalentedStudentPageState extends State<AddTalentedStudentPage> {
  Map<String, dynamic> studentInfo = {};
  bool fetchingStudentInfo = false;
  List talentList = [];
  List<Map<String, dynamic>> talents = [];
  final _formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isAdd = true;
  int? id;
  List addedTalents = [
    {
      'id': null,
      'uuid': uuid.v1(),
    }
  ];
  String? currentTalent;
  bool duplicateIds = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isAdd = context.read<AddStudentCubit>().state.isAdd;
    id = context.read<AddStudentCubit>().state.id;
    if (!isAdd) {
      Future.delayed(Duration.zero, () async {
        setState(() {
          fetchingStudentInfo = true;
        });
        Map<String, dynamic> student =
            await StudentInfoRepository().getStudentRP(id!);
        setState(() {
          studentInfo = student;
          _handleSetTalents(student['abilities']);
          fetchingStudentInfo = false;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      var response = await getTalentListPV();

      setState(() {
        talentList = response.data['data'];
      });
    });
  }

  Map<String, dynamic> _handleProcessTaskData(Map<String, dynamic> data) {
    var dataToBeProcceced = {};
    int d = 0;
    for (var i = 0; i < data.entries.length; i++) {
      var element = data.entries.toList()[i];
      if (element.key.contains('abilities_ids')) {
        dataToBeProcceced['abilities_ids[${d}]'] = element.value;
      } else if (element.key.contains('value')) {
        dataToBeProcceced['value[${d}]'] = element.value;
        d++;
      }
    }

    return {
      ...dataToBeProcceced,
      'student_id': data['student_id'],
      'group_id': data['group_id'],
    };
  }

  void _handleAddTalent() {
    List addedTalentsCopy = [...addedTalents];
    addedTalentsCopy.add({
      'id': null,
      'uuid': uuid.v1(),
    });
    setState(() {
      currentTalent = null;
      addedTalents = addedTalentsCopy;
    });
  }

  void _handleRemoveTalent(String id) {
    if (addedTalents.length > 1) {
      _formKey.currentState!
          .removeInternalFieldValue('abilities_ids[$id]', isSetState: true);
      _formKey.currentState!
          .removeInternalFieldValue('value[$id]', isSetState: true);
      addedTalents.removeWhere((element) => element['uuid'].toString() == id);
      setState(() {
        addedTalents = addedTalents;
        currentTalent = null;
        duplicateIds = false;
      });
    }
  }

  void _handleSetTalents(List t) {
    List<Map<String, dynamic>> talentsCopy = [];
    for (var i = 0; i < t.length; i++) {
      talentsCopy.add({
        'id': t[i]['ability_id'].toString(),
        'uuid': t[i]['ability_id'].toString(),
      });
    }
    setState(() {
      addedTalents = talentsCopy;
    });
  }

  void _handleSetTalentList(String id) {
    List addedTalentsCopy = [...addedTalents];

    if (addedTalents.map((e) => e['id']).contains(id)) {
      setState(() {
        duplicateIds = true;
      });
    } else {
      addedTalentsCopy[addedTalentsCopy.length - 1]['id'] = id;
      setState(() {
        duplicateIds = false;
        addedTalents = addedTalentsCopy;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
              AppLocalization.of(context)!.translate('add_talented_student')),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: AppContainer(
            child: Column(
              children: [
                !fetchingStudentInfo
                    ? FormBuilder(
                        initialValue: {...studentInfo},
                        key: _formKey,
                        child: TalentedStudentForm(
                          studentInfo: studentInfo,
                          isAdd: isAdd,
                          talents: addedTalents,
                          talentList: talentList,
                          handleRemoveTalent: _handleRemoveTalent,
                          handleSetTalentList: _handleSetTalentList,
                          formKey: _formKey,
                        ),
                      )
                    : Loading(),
                const SizedBox(height: 25),
                BlocListener<StudentsBloc, StudentsState>(
                  listener: (context, state) {
                    if (state is StudentsAddTalentedSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalization.of(context)!
                              .translate('_success_add_talented')),
                          backgroundColor: green,
                        ),
                      );
                      _formKey.currentState!.reset();
                      Navigator.pop(context);
                    } else if (state is StudentsError) {
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
            ),
          ),
        ),
        floatingActionButton: AppContainer(
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: BlocBuilder<StudentsBloc, StudentsState>(
                  builder: (context, state) {
                    return AppButton(
                      loading: state is StudentsAddTalentedLoading,
                      press: () {
                        if (duplicateIds) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalization.of(context)!
                                  .translate('duplicate_talents')),
                              backgroundColor: red,
                            ),
                          );
                          return;
                        }
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> dataTobeSent =
                              _handleProcessTaskData(
                                  _formKey.currentState!.value);
                          context
                              .read<StudentsBloc>()
                              .add(StartAddTalent(dataTobeSent));
                        }
                      },
                      text: AppLocalization.of(context)!.translate('save'),
                    );
                  },
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: AppButton(
                    press: () {
                      if (duplicateIds) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppLocalization.of(context)!
                                .translate('duplicate_talents')),
                            backgroundColor: red,
                          ),
                        );
                        return;
                      }
                      if (_formKey.currentState!.validate()) {
                        _handleAddTalent();
                      }
                    },
                    text: '+'),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

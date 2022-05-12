import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:moreinfo/bloc/groups/groups_bloc.dart';
import 'package:moreinfo/bloc/students/students_bloc.dart';
import 'package:moreinfo/data/models/student/student_model.dart';
import 'package:moreinfo/data/repositories/students/students_repository.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/common/app_dropdown.dart';
import 'package:moreinfo/presentation/common/button.dart';
import 'package:moreinfo/presentation/common/textfield.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:provider/src/provider.dart';

class TalentedStudentForm extends StatefulWidget {
  List? talentList;
  List talents;
  Function(String) handleRemoveTalent;
  Function(String) handleSetTalentList;
  GlobalKey<FormBuilderState> formKey;
  Map<String, dynamic>? studentInfo;
  bool isAdd;

  TalentedStudentForm(
      {Key? key,
      required this.talentList,
      required this.talents,
      required this.handleRemoveTalent,
      required this.handleSetTalentList,
      required this.formKey,
      required this.isAdd,
      required this.studentInfo})
      : super(key: key);

  @override
  State<TalentedStudentForm> createState() => _TalentedStudentFormState();
}

class _TalentedStudentFormState extends State<TalentedStudentForm> {
  double currentRating = 0.0;
  List<StudentModel> students = [];
  bool studentsLoading = false;
  List studentTalents = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.read<StudentsBloc>().add(StartFetchTalentList());
    context.read<GroupsBloc>().add(StartFetchGroups());
    if (!widget.isAdd && widget.studentInfo!.isNotEmpty) {
      _fetchStudents(widget.studentInfo!['group_id']);
    }
  }

  void _fetchStudents(groupId) async {
    setState(() {
      studentsLoading = true;
    });
    List<StudentModel> data = await StudentsRepository().getStudentsRP(groupId);
    if (mounted) {
      setState(() {
        students = data;
        studentsLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<GroupsBloc, GroupsState>(
          builder: (context, state) {
            return AppDropdown(
              enabled: widget.isAdd,
              onChanged: (v) {
                _fetchStudents(v);
              },
              label: state is GroupsLoading
                  ? 'Loading...'
                  : AppLocalization.of(context)!.translate('groups'),
              name: 'group_id',
              validator: FormBuilderValidators.required(
                context,
                errorText: '',
              ),
              items: state is GroupsSuccess
                  ? state.data
                      .map((e) => {'id': e.id, 'key': e.name.toString()})
                      .toList()
                  : [],
            );
          },
        ),
        const SizedBox(height: 15),
        AppDropdown(
          enabled: widget.isAdd,
          label: studentsLoading
              ? 'Loading'
              : AppLocalization.of(context)!.translate('group_students'),
          validator: FormBuilderValidators.required(
            context,
            errorText: '',
          ),
          name: 'student_id',
          items: students.map((e) => {'id': e.id, 'key': e.fio}).toList(),
        ),
        const SizedBox(height: 15),
        Column(
          children: [
            ...widget.talents.map(
              (e) => Ability(
                id: e['id'].toString(),
                uuid: e['uuid'].toString(),
                talentList: widget.talentList!,
                handleRemoveTalent: widget.handleRemoveTalent,
                handleSetTalentList: widget.handleSetTalentList,
                formKey: widget.formKey,
              ),
            )
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}

class Ability extends StatelessWidget {
  Ability({
    Key? key,
    required this.talentList,
    required this.handleRemoveTalent,
    required this.handleSetTalentList,
    required this.id,
    required this.uuid,
    required this.formKey,
  }) : super(key: key);

  List talentList;
  String id;
  String uuid;
  Function(String) handleRemoveTalent;
  Function(String) handleSetTalentList;
  GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: AppDropdown(
              onChanged: (val) {
                handleSetTalentList(val!);
              },
              key: UniqueKey(),
              label: AppLocalization.of(context)!.translate('_choose_skill'),
              name: 'abilities_ids[$uuid]',
              validator: FormBuilderValidators.required(
                context,
                errorText: '',
              ),
              items: talentList
                  .map((e) => {
                        'key': e['name'],
                        'id': e['id'].toString(),
                      })
                  .toList(),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Ball',
                //   style: const TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w600,
                //     color: primaryColorLight,
                //   ),
                // ),
                const SizedBox(height: 5),
                CommonTextField(
                  errMessageHeight: 0,
                  key: UniqueKey(),
                  labelText: '',
                  name: 'value[$uuid]',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      context,
                      errorText: '',
                    ),
                    FormBuilderValidators.min(context, 1, errorText: ''),
                    FormBuilderValidators.max(context, 100, errorText: ''),
                  ]),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Container(
            width: 50,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // formKey.currentState!.save();
                handleRemoveTalent(uuid);
              },
              child: Icon(Icons.delete),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    side: BorderSide(color: Colors.red)),
                padding: EdgeInsets.all(0),
                primary: red,
                minimumSize: Size(20, 20), //////// HERE
              ),
            ),
          ),
        ],
      ),
    );
  }
}

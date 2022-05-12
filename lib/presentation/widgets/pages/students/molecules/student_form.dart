import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:moreinfo/bloc/add_student/add_student_bloc.dart';
import 'package:moreinfo/bloc/groups/groups_bloc.dart';
import 'package:moreinfo/bloc/student_info/student_info_bloc.dart';
import 'package:moreinfo/data/repositories/add_student/add_student_repository.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/common/app_dropdown.dart';
import 'package:moreinfo/presentation/common/app_image_picker.dart';
import 'package:moreinfo/presentation/common/button.dart';
import 'package:moreinfo/presentation/common/datefield.dart';
import 'package:moreinfo/presentation/common/error.dart';
import 'package:moreinfo/presentation/common/loader.dart';
import 'package:moreinfo/presentation/common/section_divider.dart';
import 'package:moreinfo/presentation/common/textfield.dart';
import 'package:moreinfo/presentation/json/student_input_fields.dart';

class StudentForm extends StatefulWidget {
  String userImage;
  bool isAdd;
  GlobalKey<FormBuilderState> formKey;
  StudentForm({
    Key? key,
    required this.formKey,
    required this.userImage,
    required this.isAdd,
  }) : super(key: key);

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  List faculties = [];
  List specs = [];
  List groups = [];
  String? image = null;
  Map<String, dynamic> validators = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    validators = {
      'fio_validator': FormBuilderValidators.required(
        context,
        errorText: AppLocalization.of(context)!.translate('required'),
      ),
      'phone_validator': FormBuilderValidators.required(
        context,
        errorText: AppLocalization.of(context)!.translate('required'),
      ),
      'email_validator': FormBuilderValidators.email(
        context,
        errorText: AppLocalization.of(context)!.translate('valid_email'),
      ),
      'tg_validator': FormBuilderValidators.url(
        context,
        errorText: AppLocalization.of(context)!.translate('valid_link'),
      ),
      'seria_validator': FormBuilderValidators.compose([
        FormBuilderValidators.maxLength(
          context,
          2,
          errorText: AppLocalization.of(context)!.translate('max_2'),
        ),
        FormBuilderValidators.minLength(
          context,
          2,
          errorText: AppLocalization.of(context)!.translate('min_2'),
        ),
        FormBuilderValidators.match(
          context,
          r"[A-Z][A-Z]",
          errorText:
              AppLocalization.of(context)!.translate('only_uppercase_letters'),
        ),
      ]),
      'pass_num_validator': FormBuilderValidators.compose([
        FormBuilderValidators.maxLength(
          context,
          7,
          errorText: AppLocalization.of(context)!.translate('max_7'),
        ),
        FormBuilderValidators.minLength(
          context,
          7,
          errorText: AppLocalization.of(context)!.translate('min_7'),
        ),
      ]),
    };

    StudentInfoState state = context.read<StudentInfoBloc>().state;
    Map<String, dynamic>? stData =
        state is StudentInfoLoadSuccess ? state.studentInfo : {};

    Future.delayed(Duration.zero, () async {
      List data = await AddStudentRepository().getFacultiesRP();
      if (mounted) {
        setState(() {
          specs = data;
          if (!widget.isAdd) {
            faculties = specs
                .where((element) =>
                    element['id'].toString() == stData!['speciality_id'])
                .toList()[0]['speciality'];
            groups = faculties
                .where((element) =>
                    element['id'].toString() == stData!['faculty_id'])
                .toList()[0]['group'];
          }
        });
      }
    });
  }

  void setImage(String img) {
    setState(() {
      image = img;
      widget.formKey.currentState!.fields['user_photo']!.didChange(img);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildStudentForm();
  }

  Widget _buildStudentForm() {
    var required = FormBuilderValidators.required(
      context,
      errorText: AppLocalization.of(context)!.translate('required'),
    );
    return Column(
      children: [
        AppImagePicker(userImage: widget.userImage, setImage: setImage),
        Container(
          height: 0,
          child: FormBuilderTextField(
            name: 'user_photo',
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
        const SizedBox(height: 15),
        ...studentInputFields
            .map(
              (e) => Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: e['type'] == 'text'
                    ? CommonTextField(
                        autovalidateMode: e['autovalidateMode'],
                        validator: validators[e['validator'] ?? ''],
                        inputFormatters: e['inputFormatters'],
                        textInputAction: TextInputAction.next,
                        name: e['name'],
                        prefix: e['prefix'],
                        labelText:
                            AppLocalization.of(context)!.translate(e['name']),
                      )
                    : e['type'] == 'select'
                        ? AppDropdown(
                            label: AppLocalization.of(context)!
                                .translate(e['name']),
                            name: e['name'],
                            items: e['options'],
                          )
                        : e['type'] == 'date'
                            ? CommonDateField(
                                initialDatePickerMode:
                                    e['initialDatePickerMode'],
                                format: e['format'],
                                labelText: AppLocalization.of(context)!
                                    .translate(e['name']),
                                name: e['name'],
                              )
                            : Container(),
              ),
            )
            .toList(),
        AppDropdown(
          onChanged: (val) {
            widget.formKey.currentState!.fields['group_id']!.didChange(null);
            widget.formKey.currentState!.fields['faculty_id']!.didChange(null);
            setState(() {
              faculties = specs
                  .where((element) => element['id'].toString() == val)
                  .toList()[0]['speciality'];
            });
          },
          label: AppLocalization.of(context)!.translate('_directions'),
          name: "speciality_id",
          validator: required,
          items: specs.map((e) => {'id': e['id'], 'key': e['name']}).toList(),
        ),
        const SizedBox(height: 15),
        AppDropdown(
          onChanged: (val) {
            if (val != null) {
              widget.formKey.currentState!.fields['group_id']!.didChange(null);
              setState(() {
                groups = faculties
                    .where((element) => element['id'].toString() == val)
                    .toList()[0]['group'];
              });
            }
          },
          label: AppLocalization.of(context)!.translate('_faculties'),
          name: "faculty_id",
          validator: required,
          items:
              faculties.map((e) => {'id': e['id'], 'key': e['name']}).toList(),
        ),
        const SizedBox(height: 15),
        AppDropdown(
          label: AppLocalization.of(context)!.translate('groups'),
          name: "group_id",
          validator: required,
          items: groups
              .map((e) => {'id': e['id'], 'key': e['name'].toString()})
              .toList(),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

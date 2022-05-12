import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:moreinfo/bloc/add_student/add_student_bloc.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/common/app_container.dart';
import 'package:moreinfo/presentation/common/button.dart';
import 'package:moreinfo/presentation/common/section_divider.dart';
import 'package:moreinfo/presentation/common/textfield.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:moreinfo/presentation/widgets/pages/auth/molecules/enter_phone_form.dart';

class FamilyForm extends StatefulWidget {
  const FamilyForm({Key? key}) : super(key: key);

  @override
  State<FamilyForm> createState() => _FamilyFormState();
}

class _FamilyFormState extends State<FamilyForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionDivider(
            title: AppLocalization.of(context)!.translate('about_father')),
        Container(
          margin: const EdgeInsets.only(bottom: 15, top: 25),
          child: CommonTextField(
            textInputAction: TextInputAction.next,
            name: 'fam_father_fio',
            labelText: AppLocalization.of(context)!.translate('fam_father_fio'),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: CommonTextField(
            textInputAction: TextInputAction.next,
            name: 'fam_father_address',
            labelText:
                AppLocalization.of(context)!.translate('fam_father_address'),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: CommonTextField(
            textInputAction: TextInputAction.next,
            name: 'fam_father_phone',
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CustomInputFormatter(),
              LengthLimitingTextInputFormatter(11),
            ],
            prefix: const Text('+998 '),
            labelText:
                AppLocalization.of(context)!.translate('fam_father_phone'),
          ),
        ),
        const SizedBox(height: 15),
        SectionDivider(
            title: AppLocalization.of(context)!.translate('about_mother')),
        Container(
          margin: const EdgeInsets.only(bottom: 15, top: 25),
          child: CommonTextField(
            textInputAction: TextInputAction.next,
            name: 'fam_mother_fio',
            labelText: AppLocalization.of(context)!.translate('fam_mother_fio'),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: CommonTextField(
            textInputAction: TextInputAction.next,
            name: 'fam_mother_address',
            labelText:
                AppLocalization.of(context)!.translate('fam_mother_address'),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: CommonTextField(
            textInputAction: TextInputAction.next,
            name: 'fam_mother_phone',
            prefix: const Text('+998 '),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CustomInputFormatter(),
              LengthLimitingTextInputFormatter(11),
            ],
            labelText:
                AppLocalization.of(context)!.translate('fam_mother_phone'),
          ),
        ),
        BlocListener<AddStudentBloc, AddStudentState>(
          listener: (context, state) {
            if (state is AddStudentLoadFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: red,
                ),
              );
            } else if (state is AddStudentLoadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message ?? 'Success'),
                  backgroundColor: green,
                ),
              );
              Navigator.of(context).pop();
            }
          },
          child: Container(),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/common/button.dart';
import 'package:moreinfo/presentation/common/textfield.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:moreinfo/presentation/json/social_input_fields.dart';

class SocialForm extends StatelessWidget {
  const SocialForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...socialInputFields.map((e) {
          List options = e['options'];
          return RadioBuilder(
            options: options,
            name: e['name'],
          );
        }).toList(),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: CommonTextField(
            textInputAction: TextInputAction.next,
            name: 'soc_work_description',
            labelText:
                AppLocalization.of(context)!.translate('soc_work_description'),
          ),
        ),
        RadioBuilder(
          options: [
            {
              'value': 0,
              'key': AppLocalization.of(context)!.translate('living_inrelative')
            },
            {
              'value': 1,
              'key': AppLocalization.of(context)!.translate('inown_house')
            },
            {
              'value': 2,
              'key':
                  AppLocalization.of(context)!.translate('living_indormitory')
            },
            {
              'value': 3,
              'key': AppLocalization.of(context)!.translate('living_inrent')
            },
          ],
          name: 'cur_type_living',
        ),
        RadioBuilder(
          options: [
            {
              'value': 0,
              'key': AppLocalization.of(context)!.translate('_good')
            },
            {
              'value': 1,
              'key': AppLocalization.of(context)!.translate('_tolarable')
            },
            {
              'value': 2,
              'key': AppLocalization.of(context)!.translate('_bad'),
            },
          ],
          name: 'cur_living_state',
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: CommonTextField(
            textInputAction: TextInputAction.next,
            name: 'cur_living_description',
            labelText:
                AppLocalization.of(context)!.translate('living_state_comment'),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: CommonTextField(
            textInputAction: TextInputAction.next,
            name: 'cur_living_address',
            labelText:
                AppLocalization.of(context)!.translate('cur_living_address'),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

class RadioBuilder extends StatelessWidget {
  const RadioBuilder({
    Key? key,
    required this.options,
    required this.name,
  }) : super(key: key);

  final List options;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalization.of(context)!.translate(name),
            style: const TextStyle(
              color: primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          FormBuilderRadioGroup(
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.all(0),
            ),
            name: name,
            activeColor: primaryColor,
            orientation: OptionsOrientation.vertical,
            options: options
                .map<FormBuilderFieldOption>((e) => FormBuilderFieldOption(
                      value: e['value'],
                      child: Text(AppLocalization.of(context)!
                          .translate(e['key'].toString())),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

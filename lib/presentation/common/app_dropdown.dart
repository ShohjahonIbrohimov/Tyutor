import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:moreinfo/presentation/common/datefield.dart';
import 'package:moreinfo/presentation/config/constants.dart';

class AppDropdown extends StatelessWidget {
  String label;
  String name;
  dynamic? validator;
  bool enabled;

  List items;
  void Function(String?)? onChanged;
  AppDropdown({
    Key? key,
    this.validator,
    required this.label,
    this.items = const [],
    required this.name,
    this.onChanged,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label.isNotEmpty
              ? Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColorLight,
                  ),
                )
              : Container(),
          SizedBox(height: label.isNotEmpty ? 5 : 0),
          FormBuilderDropdown(
            enabled: enabled,
            key: key,
            validator: validator ?? null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: onChanged,
            decoration: InputDecoration(
              errorBorder: focusedErrorBorderStyle,
              enabledBorder: enabledBorderStyle,
              labelStyle: inputLabelStyle,
              floatingLabelStyle: floatingLabelStyle,
              errorStyle: errorStyle.copyWith(
                height: 0,
              ),
              focusedBorder: focusedBorderStyle,
              focusedErrorBorder: focusedErrorBorderStyle,
              helperText: null,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
            ),
            name: name,
            elevation: 16,
            items: items.map((d) {
              return DropdownMenuItem(
                value: d['id'].toString(),
                child: Text(d['key'].toString()),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

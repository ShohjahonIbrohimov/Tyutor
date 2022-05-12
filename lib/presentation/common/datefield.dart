import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/config/constants.dart';

const defaultRadius = BorderRadius.all(Radius.circular(10));

const enabledBorderStyle = OutlineInputBorder(
  borderRadius: defaultRadius,
  borderSide: BorderSide(color: gray, width: 1.0),
);

const focusedBorderStyle = OutlineInputBorder(
  borderRadius: defaultRadius,
  borderSide: BorderSide(color: primaryColor, width: 2.0),
);

const focusedErrorBorderStyle = OutlineInputBorder(
  borderRadius: defaultRadius,
  borderSide: BorderSide(color: red, width: 2.0),
);

const inputLabelStyle = TextStyle(
  color: gray,
);

const floatingLabelStyle = TextStyle(
  color: primaryColor,
);

const errorStyle = TextStyle(color: red);

class CommonDateField extends StatelessWidget {
  String labelText;
  String name;
  bool autofocus;
  FormFieldValidator? validator;
  TextInputType? keyboardType;
  int? maxLines;
  TextInputAction? textInputAction;
  DatePickerMode? initialDatePickerMode;
  DateFormat? format;

  CommonDateField({
    Key? key,
    required this.labelText,
    required this.name,
    this.keyboardType = TextInputType.text,
    this.autofocus = false,
    this.validator,
    this.maxLines = null,
    this.textInputAction,
    this.initialDatePickerMode,
    this.format,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      initialDatePickerMode: initialDatePickerMode ?? DatePickerMode.day,
      format: format ?? DateFormat('yyyy-MM-dd'),
      textInputAction: textInputAction,
      maxLines: null,
      validator: validator ?? FormBuilderValidators.compose([]),
      name: name,
      decoration: InputDecoration(
        errorBorder: focusedErrorBorderStyle,
        enabledBorder: enabledBorderStyle,
        labelStyle: inputLabelStyle,
        floatingLabelStyle: floatingLabelStyle,
        errorStyle: errorStyle,
        focusedBorder: focusedBorderStyle,
        focusedErrorBorder: focusedErrorBorderStyle,
        labelText: labelText,
        helperText: null,
        contentPadding: const EdgeInsets.all(15),
      ),
    );
  }
}

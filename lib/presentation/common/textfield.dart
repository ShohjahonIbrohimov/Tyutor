import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/common/styles/styles.dart';
import 'package:moreinfo/presentation/config/constants.dart';

class CommonTextField extends StatelessWidget {
  String labelText;
  String name;
  bool autofocus;
  dynamic? validator;
  TextInputType? keyboardType;
  int? maxLines;
  TextInputAction? textInputAction;
  Widget? prefixIcon;
  Widget? prefix;
  List<TextInputFormatter>? inputFormatters;
  AutovalidateMode? autovalidateMode;
  double? errMessageHeight;

  CommonTextField({
    Key? key,
    required this.labelText,
    required this.name,
    this.keyboardType = TextInputType.text,
    this.autofocus = false,
    this.validator,
    this.maxLines = null,
    this.textInputAction,
    this.inputFormatters,
    this.prefixIcon,
    this.prefix,
    this.errMessageHeight,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: FormBuilderTextField(
        key: key,
        autovalidateMode:
            autovalidateMode ?? AutovalidateMode.onUserInteraction,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        maxLines: null,
        validator: validator ?? FormBuilderValidators.compose([]),
        name: name,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefix: prefix,
          prefixIcon: prefixIcon,
          errorBorder: focusedErrorBorderStyle,
          enabledBorder: enabledBorderStyle,
          labelStyle: inputLabelStyle,
          floatingLabelStyle: floatingLabelStyle,
          errorStyle: errorStyle.copyWith(
            height: errMessageHeight,
          ),
          focusedBorder: focusedBorderStyle,
          focusedErrorBorder: focusedErrorBorderStyle,
          labelText: labelText,
          helperText: null,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }
}

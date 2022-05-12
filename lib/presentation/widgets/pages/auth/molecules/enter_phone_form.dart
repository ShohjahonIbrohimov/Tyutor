import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:moreinfo/bloc/login/login_bloc.dart';
import 'package:moreinfo/cubit/reset_pass/reset_pass_cubit.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/common/button.dart';
import 'package:moreinfo/presentation/common/textfield.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:provider/src/provider.dart';

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;
    int length = text.length;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();

    if (length < 2) {
      buffer.write(text);
    } else if (length > 2 && length <= 5) {
      buffer.write('${text.substring(0, 2)} ${text.substring(2)}');
    } else if (length >= 6) {
      buffer.write(
          '${text.substring(0, 2)} ${text.substring(2, 5)} ${text.substring(5)}');
    } else {
      buffer.write(text);
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class EnterPhoneForm extends StatelessWidget {
  Function(int) handleSetPage;
  EnterPhoneForm({Key? key, required this.handleSetPage}) : super(key: key);

  static final _formKey2 = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var required = FormBuilderValidators.required(
      context,
      errorText: AppLocalization.of(context)!.translate('required'),
    );
    return FormBuilder(
      key: _formKey2,
      child: Column(
        children: [
          Text(
            AppLocalization.of(context)!.translate('enter_phone'),
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 20),
          CommonTextField(
            name: 'phone',
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CustomInputFormatter(),
              LengthLimitingTextInputFormatter(11),
            ],
            prefix: const Text('+998 '),
            labelText: AppLocalization.of(context)!.translate('phone_num'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 25),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return AppButton(
                loading: state is LoginLoading,
                press: () {
                  _formKey2.currentState!.save();
                  if (_formKey2.currentState!.validate()) {
                    String phone = _formKey2.currentState!.value['phone'];
                    String phoneTrimmed = '+998${phone.replaceAll(' ', '')}';
                    context
                        .read<ResetPassCubit>()
                        .setPhone(ResetPassModel(phone: phoneTrimmed));
                    context
                        .read<LoginBloc>()
                        .add(ResetGetCode(ResetPassModel(phone: phoneTrimmed)));
                  }
                },
                text:
                    AppLocalization.of(context)!.translate('get_confirmation'),
              );
            },
          ),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: red,
                  ),
                );
              } else if (state is LoginSuccess) {
                handleSetPage(1);
              }
            },
            child: Container(),
          )
        ],
      ),
    );
  }
}

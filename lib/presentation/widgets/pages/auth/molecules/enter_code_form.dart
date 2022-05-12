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

class EnterCodeForm extends StatelessWidget {
  Function(int) handleSetPage;
  EnterCodeForm({Key? key, required this.handleSetPage}) : super(key: key);

  static final _formKey3 = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var required = FormBuilderValidators.required(
      context,
      errorText: AppLocalization.of(context)!.translate('required'),
    );
    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey3,
        child: Column(
          children: [
            Text(
              AppLocalization.of(context)!.translate('enter_code'),
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  color: Color(0XFFBDBDBD),
                  fontSize: 16,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text:
                          '${AppLocalization.of(context)!.translate('pass_sent')}  '),
                  TextSpan(
                    text: context.read<ResetPassCubit>().state!.phone,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: primaryColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CommonTextField(
              name: 'code',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              validator: required,
              labelText: AppLocalization.of(context)!.translate('code'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 25),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return AppButton(
                  loading: state is LoginLoading,
                  press: () {
                    _formKey3.currentState!.save();
                    if (_formKey3.currentState!.validate()) {
                      // String lang = context.read<LanguageCubit>().state;
                      String code = _formKey3.currentState!.value['code'];
                      String? phone =
                          context.read<ResetPassCubit>().state!.phone;
                      context.read<ResetPassCubit>().setPhone(ResetPassModel(
                            code: code,
                            phone: phone,
                          ));
                      context.read<LoginBloc>().add(
                            ResetSendCode(ResetPassModel(
                              code: code,
                              phone: phone,
                            )),
                          );
                    }
                  },
                  text: AppLocalization.of(context)!.translate('confirm'),
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
                  handleSetPage(2);
                }
              },
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}

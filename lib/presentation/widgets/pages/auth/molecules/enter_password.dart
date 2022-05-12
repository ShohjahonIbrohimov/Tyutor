import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:moreinfo/bloc/login/login_bloc.dart';
import 'package:moreinfo/cubit/auth/login_cubit.dart';
import 'package:moreinfo/cubit/auth/token_cubit.dart';
import 'package:moreinfo/cubit/auth/user_data_cubit.dart';
import 'package:moreinfo/cubit/reset_pass/reset_pass_cubit.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/l10n/cubit/language_cubit.dart';
import 'package:moreinfo/presentation/common/button.dart';
import 'package:moreinfo/presentation/common/textfield.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:provider/src/provider.dart';

class EnterPasswordForm extends StatelessWidget {
  EnterPasswordForm({Key? key}) : super(key: key);

  static final _formKey4 = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var required = FormBuilderValidators.required(
      context,
      errorText: AppLocalization.of(context)!.translate('required'),
    );
    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey4,
        child: Column(
          children: [
            Text(
              AppLocalization.of(context)!.translate('new_password'),
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 20),
            CommonTextField(
              name: 'password',
              validator: required,
              labelText: AppLocalization.of(context)!.translate('password'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 25),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return AppButton(
                  loading: state is LoginLoading,
                  press: () {
                    _formKey4.currentState!.save();
                    if (_formKey4.currentState!.validate()) {
                      String password =
                          _formKey4.currentState!.value['password'];
                      String? phone =
                          context.read<ResetPassCubit>().state!.phone;
                      String? code = context.read<ResetPassCubit>().state!.code;
                      context.read<ResetPassCubit>().setPhone(ResetPassModel(
                            code: code,
                            phone: phone,
                            password: password,
                          ));
                      context.read<LoginBloc>().add(
                            ResetSendNewPassword(ResetPassModel(
                              code: code,
                              phone: phone,
                              password: password,
                            )),
                          );
                    }
                  },
                  text: AppLocalization.of(context)!.translate('update_pass'),
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
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalization.of(context)!
                          .translate('pass_update_success')),
                      backgroundColor: green,
                    ),
                  );
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

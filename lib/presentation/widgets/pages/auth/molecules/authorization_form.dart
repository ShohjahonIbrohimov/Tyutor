import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:moreinfo/bloc/login/login_bloc.dart';
import 'package:moreinfo/bloc/login/types.dart';
import 'package:moreinfo/cubit/user/user_cubit.dart';
import 'package:moreinfo/data/models/user/user_model.dart';
import 'package:moreinfo/data/providers/public/login_provider.dart';
import 'package:moreinfo/data/repositories/auth/auth_repository.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/common/button.dart';
import 'package:moreinfo/presentation/common/textfield.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:provider/src/provider.dart';

class AuthorizationForm extends StatefulWidget {
  AuthorizationForm({Key? key}) : super(key: key);

  static final _formKey1 = GlobalKey<FormBuilderState>();

  @override
  State<AuthorizationForm> createState() => _AuthorizationFormState();
}

class _AuthorizationFormState extends State<AuthorizationForm> {
  @override
  Widget build(BuildContext context) {
    var required = FormBuilderValidators.required(
      context,
      errorText: AppLocalization.of(context)!.translate('required'),
    );
    return Align(
      child: SingleChildScrollView(
        child: FormBuilder(
          key: AuthorizationForm._formKey1,
          child: Column(
            children: [
              CommonTextField(
                name: 'username',
                validator: required,
                labelText: AppLocalization.of(context)!.translate('login'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
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
                      AuthorizationForm._formKey1.currentState!.save();
                      if (AuthorizationForm._formKey1.currentState!
                          .validate()) {
                        String username = AuthorizationForm
                            ._formKey1.currentState!.value['username'];
                        String password = AuthorizationForm
                            ._formKey1.currentState!.value['password'];
                        context.read<LoginBloc>().add(
                              LoginWithCredentials(
                                LoginCredentials(
                                  username: username,
                                  password: password,
                                ),
                              ),
                            );
                      }
                    },
                    text: AppLocalization.of(context)!.translate('comein'),
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
                    context
                        .read<UserCubit>()
                        .setUser(UserModel.fromJson(state.user_data!));
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/cabinet_home", (route) => false);
                  }
                },
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

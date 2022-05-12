import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:moreinfo/bloc/reset_pass/resetpass_bloc.dart';
import 'package:moreinfo/bloc/reset_pass/types.dart';
import 'package:moreinfo/data/providers/config.dart';
import 'package:moreinfo/data/repositories/auth/token_repository.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/l10n/cubit/language_cubit.dart';
import 'package:moreinfo/presentation/common/app_container.dart';
import 'package:moreinfo/presentation/common/app_dropdown.dart';
import 'package:moreinfo/presentation/common/button.dart';
import 'package:moreinfo/presentation/common/textfield.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:provider/src/provider.dart';
import 'package:restart_app/restart_app.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context)!.translate('settings')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: AppContainer(
          child: FormBuilder(
            initialValue: {'lang': context.read<LanguageCubit>().state},
            key: _formKey,
            child: Column(
              children: [
                SectionDivider(
                    title:
                        AppLocalization.of(context)!.translate('reset_pass')),
                Container(
                  margin: const EdgeInsets.only(bottom: 15, top: 15),
                  child: CommonTextField(
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: FormBuilderValidators.required(
                      context,
                      errorText:
                          AppLocalization.of(context)!.translate('required'),
                    ),
                    textInputAction: TextInputAction.next,
                    name: 'old_password',
                    labelText:
                        AppLocalization.of(context)!.translate('old_pass'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: CommonTextField(
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: FormBuilderValidators.required(
                      context,
                      errorText:
                          AppLocalization.of(context)!.translate('required'),
                    ),
                    textInputAction: TextInputAction.next,
                    name: 'new_password',
                    labelText:
                        AppLocalization.of(context)!.translate('new_pass'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: CommonTextField(
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: FormBuilderValidators.required(
                        context,
                        errorText:
                            AppLocalization.of(context)!.translate('required'),
                      ),
                      textInputAction: TextInputAction.next,
                      name: 'new_pass_confirm',
                      labelText: AppLocalization.of(context)!
                          .translate('new_pass_confirm')),
                ),
                BlocListener<ResetPassBloc, ResetPassState>(
                  listener: (context, state) {
                    if (state is ResetPassSuccess) {
                      // _formKey.currentState.
                      _formKey.currentState!.reset();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalization.of(context)!
                              .translate('pass_update_success')),
                          backgroundColor: green,
                        ),
                      );
                    } else if (state is ResetPassError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: red,
                        ),
                      );
                    }
                  },
                  child: Container(),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: AppContainer(
        child: BlocBuilder<ResetPassBloc, ResetPassState>(
          builder: (context, state) {
            return AppButton(
              loading: state is ResetPassLoading,
              press: () {
                _formKey.currentState!.save();
                if (_formKey.currentState!.validate()) {
                  String old_password =
                      _formKey.currentState!.value['old_password'];
                  String new_password =
                      _formKey.currentState!.value['new_password'];
                  context.read<ResetPassBloc>().add(StartResetPass(
                      ResetPassModel(
                          old_password: old_password,
                          new_password: new_password)));
                }
              },
              text: AppLocalization.of(context)!.translate('save'),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class SectionDivider extends StatelessWidget {
  String title;
  SectionDivider({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
        Text(
          title,
          style: TextStyle(color: Colors.grey.shade300),
        ),
        Expanded(
          flex: 5,
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}

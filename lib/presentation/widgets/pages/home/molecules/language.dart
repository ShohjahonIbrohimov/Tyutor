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

class AppLanguage extends StatefulWidget {
  const AppLanguage({Key? key}) : super(key: key);

  @override
  State<AppLanguage> createState() => _AppLanguageState();
}

class _AppLanguageState extends State<AppLanguage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context)!.translate('app_lang')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: AppContainer(
          child: FormBuilder(
            initialValue: {'lang': context.read<LanguageCubit>().state},
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 15),
                AppDropdown(
                  onChanged: (value) {
                    context.read<LanguageCubit>().changeLocale(value);
                    TokenRepository().setLanguage(value!);
                    dio.interceptors.first = InterceptorsWrapper(
                      onRequest: (options, handler) {
                        String path = options.path;
                        options.path = '${path}/${value}';
                        return handler.next(options);
                      },
                      onError: (DioError e, handler) async {
                        if (e.response!.statusCode == 401) {
                          await TokenRepository().removeToken();
                          Restart.restartApp();
                        }

                        return handler.next(e);
                      },
                    );
                  },
                  label: '',
                  name: 'lang',
                  items: const [
                    {'id': 'uz', 'key': "O'zbek"},
                    {'id': 'ru', 'key': 'Pусский'},
                    {'id': 'en', 'key': 'English'},
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

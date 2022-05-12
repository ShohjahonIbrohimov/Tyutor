import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:moreinfo/bloc/auth/auth_bloc.dart';
import 'package:moreinfo/cubit/add_student/add_student_cubit.dart';
import 'package:moreinfo/cubit/app_menu/app_menu_cubit.dart';
import 'package:moreinfo/cubit/auth/token_cubit.dart';
import 'package:moreinfo/cubit/auth/user_data_cubit.dart';
import 'package:moreinfo/cubit/group/current_group_cubit.dart';
import 'package:moreinfo/cubit/location/location_cubit.dart';
import 'package:moreinfo/cubit/news/news_cubit.dart';
import 'package:moreinfo/cubit/task/task_cubit.dart';
import 'package:moreinfo/cubit/user/user_cubit.dart';
import 'package:moreinfo/data/repositories/auth/auth_repository.dart';
import 'package:moreinfo/data/repositories/auth/token_repository.dart';
import 'package:moreinfo/data/repositories/news/news_repository.dart';
import 'package:moreinfo/l10n/app_localization.dart' as l10;
import 'package:moreinfo/l10n/cubit/language_cubit.dart';
import 'package:moreinfo/presentation/config/theme.dart';
import 'package:moreinfo/presentation/core/auth_page.dart';
import 'package:moreinfo/presentation/routes/routes.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LanguageCubit(),
        ),
        BlocProvider(
          create: (_) => NewsCubit(),
        ),
        BlocProvider(
          create: (_) => CurrentGroupCubit(),
        ),
        BlocProvider(
          create: (_) => AppMenuCubit(),
        ),
        BlocProvider(
          create: (_) => LocationCubit(),
        ),
        BlocProvider(
          create: (_) => AuthBloc(apiRepository: TokenRepository()),
        ),
        BlocProvider(
          create: (_) => TokenCubit(),
        ),
        BlocProvider(
          create: (_) => UserDataCubit(),
        ),
        BlocProvider(
          create: (_) => AddStudentCubit(),
        ),
        BlocProvider(
          create: (_) => TaskCubit(),
        ),
        BlocProvider(
          create: (_) => UserCubit(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, String>(
        builder: (context, locale) {
          return MaterialApp(
            home: const AuthPage(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.generateRoute,
            theme: theme,
            locale: Locale(locale),
            localizationsDelegates: const [
              FormBuilderLocalizations.delegate,
              l10.AppLocalizationDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ru', 'RU'),
              Locale('en', 'EN'),
              Locale('uz', 'UZ'),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/bloc/login/login_bloc.dart';
import 'package:moreinfo/cubit/reset_pass/reset_pass_cubit.dart';
import 'package:moreinfo/data/repositories/auth/auth_repository.dart';
import 'package:moreinfo/data/repositories/auth/token_repository.dart';
import 'package:moreinfo/presentation/config/size_config.dart';
import 'package:moreinfo/presentation/widgets/pages/auth/index.dart';
import 'package:moreinfo/presentation/widgets/pages/auth/reset_password_page.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ResetPassCubit(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(
            apiRepository: AuthRepository(),
            tokenRepository: TokenRepository(),
          ),
        )
      ],
      child: const SafeArea(
        child: Scaffold(
          body: ResetPasswordPage(),
        ),
      ),
    );
  }
}

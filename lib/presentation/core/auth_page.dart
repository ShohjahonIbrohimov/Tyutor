import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/bloc/auth/auth_bloc.dart';
import 'package:moreinfo/cubit/auth/token_cubit.dart';
import 'package:moreinfo/cubit/auth/user_data_cubit.dart';
import 'package:moreinfo/cubit/user/user_cubit.dart';
import 'package:moreinfo/data/models/user/user_model.dart';
import 'package:moreinfo/data/repositories/auth/token_repository.dart';
import 'package:moreinfo/l10n/cubit/language_cubit.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      String? language = await TokenRepository().getLanguage();
      context.read<LanguageCubit>().changeLocale(language);
    });
    context.read<AuthBloc>().add(Authenticate());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is Authenticating) {
                  return Center(
                    child: Container(
                      color: Colors.white,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Container();
              },
            ),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  context.read<TokenCubit>().setToken(state.token);
                  context
                      .read<UserCubit>()
                      .setUser(UserModel.fromJson(state.user_data));
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/cabinet_home", (route) => false);
                } else if (state is UnAuthenticated) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/intro", (route) => false);
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

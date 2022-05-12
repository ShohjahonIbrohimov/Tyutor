import 'package:flutter/material.dart';
import 'package:moreinfo/bloc/auth/auth_bloc.dart';
import 'package:moreinfo/bloc/news/news_bloc.dart';
import 'package:moreinfo/cubit/user/user_cubit.dart';
import 'package:moreinfo/data/models/user/user_model.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:moreinfo/l10n/cubit/language_cubit.dart';
import 'package:provider/src/provider.dart';

class UserMenu extends StatefulWidget {
  UserMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  UserModel? user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    user = context.read<UserCubit>().state;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.account_circle),
      onSelected: (value) {
        if (value == '1') {
          Navigator.pushNamed(context, '/settings');
        } else if (value == '2') {
          Navigator.pushNamed(context, '/lang').then((value) {
            context.read<NewsBloc>().add(StartFetchNews(1));
          });
        } else {
          context.read<AuthBloc>().add(Logout());
          Navigator.pushNamedAndRemoveUntil(
              context, "/start_auth", (route) => false);
        }
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: Container(
            padding: const EdgeInsets.only(bottom: 5),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0XFFBDBDBD)),
              ),
            ),
            child: Text(
              user?.fio ?? '',
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          value: '0',
        ),
        PopupMenuItem(
          child: Row(
            children: [
              const Icon(
                Icons.settings,
                color: primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalization.of(context)!.translate('settings'),
                style: const TextStyle(color: primaryColor),
              )
            ],
          ),
          value: '1',
        ),
        PopupMenuItem(
          child: Row(
            children: [
              const Icon(
                Icons.language,
                color: primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalization.of(context)!.translate('app_lang'),
                style: const TextStyle(color: primaryColor),
              )
            ],
          ),
          value: '2',
        ),
        PopupMenuItem(
          child: Row(
            children: [
              const Icon(
                Icons.logout,
                color: primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalization.of(context)!.translate('logout'),
                style: const TextStyle(color: primaryColor),
              )
            ],
          ),
          value: '3',
        )
      ],
    );
  }
}

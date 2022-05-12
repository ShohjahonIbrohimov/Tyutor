import 'package:flutter/material.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/common/app_container.dart';
import 'package:moreinfo/presentation/config/constants.dart';

import 'molecules/authorization_form.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AppContainer(
        child: Column(
          children: [
            const SizedBox(height: 45),
            Image.asset(
              'assets/images/logo2.png',
              width: 80,
            ),
            const SizedBox(height: 10),
            const Text(
              "Oliy va o'rta maxsus ta'lim vazirligi",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 70),
            const Text(
              'TYUTOR',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 40),
            AuthorizationForm(),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomLeft,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/reset_password');
                  },
                  child: Text(
                    AppLocalization.of(context)!.translate('forgot_pass'),
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

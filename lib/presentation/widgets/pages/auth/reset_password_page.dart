import 'package:flutter/material.dart';
import 'package:moreinfo/presentation/common/app_container.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:moreinfo/presentation/widgets/pages/auth/molecules/enter_code_form.dart';
import 'package:moreinfo/presentation/widgets/pages/auth/molecules/enter_password.dart';
import 'package:moreinfo/presentation/widgets/pages/auth/molecules/enter_phone_form.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  int currentPage = 0;

  void _handleSetPage(int num) {
    setState(() {
      currentPage = num;
    });
  }

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
            currentPage == 0
                ? EnterPhoneForm(
                    handleSetPage: _handleSetPage,
                  )
                : currentPage == 1
                    ? EnterCodeForm(
                        handleSetPage: _handleSetPage,
                      )
                    : EnterPasswordForm(),
          ],
        ),
      ),
    );
  }
}

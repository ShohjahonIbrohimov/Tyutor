import 'package:flutter/material.dart';
import 'package:moreinfo/presentation/widgets/pages/home/molecules/language.dart';
import 'package:moreinfo/presentation/widgets/pages/home/molecules/settings_form.dart';

class LangPage extends StatelessWidget {
  const LangPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: AppLanguage());
  }
}

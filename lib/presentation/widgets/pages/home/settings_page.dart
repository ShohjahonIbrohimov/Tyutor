import 'package:flutter/material.dart';
import 'package:moreinfo/presentation/widgets/pages/home/molecules/settings_form.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SettingsForm());
  }
}

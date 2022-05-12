import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/bloc/reset_pass/resetpass_bloc.dart';
import 'package:moreinfo/data/repositories/resetpass/resetpass_repository.dart';
import 'package:moreinfo/presentation/widgets/pages/home/settings_page.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPassBloc(apiRepository: ResetPassRepository()),
      child: SettingsPage(),
    );
  }
}

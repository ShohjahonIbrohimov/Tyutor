import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/bloc/homework/homework_bloc.dart';
import 'package:moreinfo/data/repositories/homework/homework_repository.dart';
import 'package:moreinfo/presentation/widgets/pages/homework/index.dart';
import 'package:moreinfo/presentation/widgets/pages/report/index.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeworkBloc(apiRepository: HomeworkRepository()),
      child: HomeworkPage(),
    );
  }
}

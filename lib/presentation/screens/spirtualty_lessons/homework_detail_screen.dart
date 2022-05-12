import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/bloc/homework/homework_bloc.dart';
import 'package:moreinfo/bloc/task_upload/taskupload_bloc.dart';
import 'package:moreinfo/data/repositories/homework/homework_repository.dart';
import 'package:moreinfo/presentation/widgets/pages/homework/homework_detail_page.dart';
import 'package:moreinfo/presentation/widgets/pages/report/report_detail_page.dart';

class HomeworkDetailScreen extends StatelessWidget {
  const HomeworkDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              HomeworkBloc(apiRepository: HomeworkRepository()),
        ),
        BlocProvider(
          create: (context) =>
              TaskUploadBloc(apiRepository: HomeworkRepository()),
        ),
      ],
      child: HomeworkDetailPage(),
    );
  }
}

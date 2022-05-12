import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/bloc/groups/groups_bloc.dart';
import 'package:moreinfo/bloc/student_info/student_info_bloc.dart';
import 'package:moreinfo/bloc/students/students_bloc.dart';
import 'package:moreinfo/data/repositories/groups/groups_repository.dart';
import 'package:moreinfo/data/repositories/student_info/student_info_repository.dart';
import 'package:moreinfo/data/repositories/students/students_repository.dart';
import 'package:moreinfo/presentation/widgets/pages/students/index.dart';
import 'package:moreinfo/presentation/widgets/pages/talented_students/index.dart';

class TalentedStudentsScreen extends StatelessWidget {
  const TalentedStudentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StudentsBloc(
            apiRepository: StudentsRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => StudentInfoBloc(
            apiRepository: StudentInfoRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => GroupsBloc(
            apiRepository: GroupsRepository(),
          ),
        ),
      ],
      child: TalentedStudentsPage(),
    );
  }
}

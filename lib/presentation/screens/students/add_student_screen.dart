import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/bloc/add_student/add_student_bloc.dart';
import 'package:moreinfo/bloc/groups/groups_bloc.dart';
import 'package:moreinfo/bloc/student_info/student_info_bloc.dart';
import 'package:moreinfo/cubit/add_student/add_student_cubit.dart';
import 'package:moreinfo/data/repositories/add_student/add_student_repository.dart';
import 'package:moreinfo/data/repositories/groups/groups_repository.dart';
import 'package:moreinfo/data/repositories/student_info/student_info_repository.dart';
import 'package:moreinfo/presentation/widgets/pages/students/add_student_page.dart';

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddStudentBloc(
            apiRepository: AddStudentRepository(),
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
      child: AddStudentPage(),
    );
  }
}

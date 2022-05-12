import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/bloc/groups/groups_bloc.dart';
import 'package:moreinfo/bloc/students/students_bloc.dart';
import 'package:moreinfo/cubit/add_student/add_student_cubit.dart';
import 'package:moreinfo/data/models/student/student_model.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/common/app_container.dart';
import 'package:moreinfo/presentation/common/error.dart';
import 'package:moreinfo/presentation/common/loader.dart';
import 'package:moreinfo/presentation/common/nodata.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:moreinfo/presentation/widgets/pages/students/molecules/student_card.dart';
import 'package:provider/src/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TalentedStudentsPage extends StatefulWidget {
  TalentedStudentsPage({Key? key}) : super(key: key);

  @override
  State<TalentedStudentsPage> createState() => _TalentedStudentsPageState();
}

class _TalentedStudentsPageState extends State<TalentedStudentsPage> {
  String type = '1';
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _handleSetType(String t) {
    setState(() {
      type = t;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.read<StudentsBloc>().add(StartFetchTalentedStudents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () async {
          context.read<StudentsBloc>().add(StartFetchTalentedStudents());
          await Future.delayed(Duration(milliseconds: 500));
          _refreshController.refreshCompleted();
        },
        child: BlocBuilder<StudentsBloc, StudentsState>(
          builder: (context, state) {
            if (state is StudentsLoading) {
              return const Center(child: Loading());
            } else if (state is StudentsSuccess) {
              if (state.talentedStudents!.isEmpty) {
                return const NoData();
              }
              return _buildStudentsList(state.talentedStudents!);
            } else if (state is StudentsError) {
              return CustomError(text: state.message);
            } else if (state is StudentsInitial) {
              return Center(
                child: Text(
                    AppLocalization.of(context)!.translate('filter_to_see')),
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          context
              .read<AddStudentCubit>()
              .setIsAdd(AddStudentCubitModel(isAdd: true));
          Navigator.pushNamed(context, '/add_talented_student').then((value) {
            context.read<StudentsBloc>().add(StartFetchTalentedStudents());
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStudentsList(List students) {
    return SingleChildScrollView(
      child: AppContainer(
        child: Column(
          children: students
              .map(
                (e) => StudentCard(
                  name: e['fio'],
                  region: e['cur_living_address'] ?? '',
                  conditiion: e['status'] ?? 0,
                  conditionDesc: e['cur_living_description'] ?? '',
                  id: e['id'],
                  onTap: () {
                    context.read<AddStudentCubit>().setIsAdd(
                        AddStudentCubitModel(isAdd: false, id: e['id']));
                    Navigator.pushNamed(context, '/add_talented_student')
                        .then((value) {
                      context
                          .read<StudentsBloc>()
                          .add(StartFetchTalentedStudents());
                    });
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/bloc/groups/groups_bloc.dart';
import 'package:moreinfo/bloc/students/students_bloc.dart';
import 'package:moreinfo/cubit/add_student/add_student_cubit.dart';
import 'package:moreinfo/cubit/group/current_group_cubit.dart';
import 'package:moreinfo/data/models/groups/groups_model.dart';
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

import 'molecules/filter.dart';

class StudentsPage extends StatefulWidget {
  StudentsPage({Key? key}) : super(key: key);

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  late CurrentGroupCubit currentGroupCubit;
  String? grup;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentGroupCubit = BlocProvider.of<CurrentGroupCubit>(context);

    context.read<GroupsBloc>().add(StartFetchGroups());
    GroupsModel? group = currentGroupCubit.state;
    if (group != null) {
      context.read<StudentsBloc>().add(StartFetchStudents(group.id.toString()));
    }
  }

  _handleSetGroup(String? id) {
    grup = id;
  }

  @override
  void dispose() {
    currentGroupCubit.setCurrentGroup(null);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () async {
          context.read<GroupsBloc>().add(StartFetchGroups());
          if (grup != null) {
            context
                .read<StudentsBloc>()
                .add(StartFetchStudents(grup!.toString()));
          }
          await Future.delayed(Duration(milliseconds: 500));
          _refreshController.refreshCompleted();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BlocBuilder<GroupsBloc, GroupsState>(
              builder: (context, state) {
                if (state is GroupsLoading) {
                  return AppContainer(
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Loading(isSmall: true),
                    ),
                  );
                } else if (state is GroupsSuccess) {
                  return StudentFilter(
                    handleSetGroup: _handleSetGroup,
                    groups: state.data,
                  );
                } else if (state is GroupsError) {
                  return CustomError(text: state.message);
                }
                return Container();
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<StudentsBloc, StudentsState>(
              builder: (context, state) {
                if (state is StudentsLoading) {
                  return Expanded(child: Center(child: Loading()));
                } else if (state is StudentsGroupSuccess) {
                  if (state.data!.isEmpty) {
                    return const Expanded(child: NoData());
                  }
                  return _buildStudentsList(state.data);
                } else if (state is StudentsError) {
                  return CustomError(text: state.message);
                } else if (state is StudentsInitial) {
                  return Expanded(
                    child: Center(
                      child: Text(AppLocalization.of(context)!
                          .translate('filter_to_see')),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          context
              .read<AddStudentCubit>()
              .setIsAdd(AddStudentCubitModel(isAdd: true));
          Navigator.pushNamed(context, '/add_student');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStudentsList(List<StudentModel>? students) {
    return SingleChildScrollView(
      child: AppContainer(
        child: Column(
          children: students!
              .map(
                (e) => StudentCard(
                  name: e.fio,
                  region: e.cur_living_address,
                  conditiion: e.status,
                  conditionDesc: e.cur_living_description,
                  id: e.id,
                  onTap: () {
                    context
                        .read<AddStudentCubit>()
                        .setIsAdd(AddStudentCubitModel(isAdd: false, id: e.id));
                    Navigator.pushNamed(context, '/add_student');
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

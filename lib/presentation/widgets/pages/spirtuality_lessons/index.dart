import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/bloc/homework/homework_bloc.dart';
import 'package:moreinfo/data/models/homework/homework_model.dart';
import 'package:moreinfo/data/models/student/student_model.dart';
import 'package:moreinfo/data/providers/private/homework/get_tasks_provider.dart';
import 'package:moreinfo/presentation/common/app_container.dart';
import 'package:moreinfo/presentation/common/error.dart';
import 'package:moreinfo/presentation/common/loader.dart';
import 'package:moreinfo/presentation/common/nodata.dart';
import 'package:moreinfo/presentation/widgets/pages/homework/molecules/homework_card.dart';
import 'package:moreinfo/presentation/widgets/pages/homework/molecules/homework_filter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SpirtualityLessonsPage extends StatefulWidget {
  SpirtualityLessonsPage({Key? key}) : super(key: key);

  @override
  State<SpirtualityLessonsPage> createState() => _SpirtualityLessonsPageState();
}

class _SpirtualityLessonsPageState extends State<SpirtualityLessonsPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.read<HomeworkBloc>().add(StartFetchSpirtualLessons());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () async {
          context.read<HomeworkBloc>().add(StartFetchSpirtualLessons());
          await Future.delayed(Duration(milliseconds: 500));
          _refreshController.refreshCompleted();
        },
        child: BlocBuilder<HomeworkBloc, HomeworkState>(
          builder: (context, state) {
            if (state is HomeworkLoading) {
              return const Center(child: Loading());
            } else if (state is HomeworkSuccess) {
              if (state.data!.isEmpty) {
                return const NoData();
              }
              return _buildHomeworkList(state.data!);
            } else if (state is HomeworkError) {
              return CustomError(text: state.message);
            } else if (state is HomeworkInitial) {
              return const Center(
                child: Text('Filter to see students'),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildHomeworkList(List<HomeworkModel> homework) {
    return SingleChildScrollView(
      child: AppContainer(
        child: Column(
          children: [
            // HomeworkFilter(),
            // const SizedBox(height: 10),
            ...homework
                .map(
                  (e) => HomeworkCard(
                    id: e.id,
                    description: e.description,
                    status: e.status,
                    onGoBack: () {
                      context
                          .read<HomeworkBloc>()
                          .add(StartFetchSpirtualLessons());
                    },
                    toRoute: '/homework_detail',
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}

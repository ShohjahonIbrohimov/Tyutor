import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/bloc/groups/groups_bloc.dart';
import 'package:moreinfo/data/models/groups/groups_model.dart';
import 'package:moreinfo/presentation/common/app_container.dart';
import 'package:moreinfo/presentation/common/error.dart';
import 'package:moreinfo/presentation/common/loader.dart';
import 'package:moreinfo/presentation/common/nodata.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:moreinfo/presentation/widgets/pages/home/molecules/group_card.dart';
import 'package:provider/src/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.read<GroupsBloc>().add(StartFetchGroups());
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: () async {
        context.read<GroupsBloc>().add(StartFetchGroups());
        await Future.delayed(Duration(milliseconds: 500));
        _refreshController.refreshCompleted();
      },
      child: BlocBuilder<GroupsBloc, GroupsState>(
        builder: (context, state) {
          if (state is GroupsLoading) {
            return const Center(child: Loading());
          } else if (state is GroupsSuccess) {
            if (state.data.isEmpty) {
              return const NoData();
            }
            return _buildProjectsList(state.data);
          } else if (state is GroupsError) {
            return CustomError(text: state.message);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildProjectsList(List<GroupsModel> groups) {
    return SingleChildScrollView(
      child: AppContainer(
        child: Column(
          children: groups.map((e) => GroupCard(group: e)).toList(),
        ),
      ),
    );
  }
}

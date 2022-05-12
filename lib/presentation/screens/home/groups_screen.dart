import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/bloc/groups/groups_bloc.dart';
import 'package:moreinfo/data/repositories/groups/groups_repository.dart';
import 'package:moreinfo/presentation/widgets/pages/home/groups_page.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupsBloc(
        apiRepository: GroupsRepository(),
      ),
      child: GroupsPage(),
    );
  }
}

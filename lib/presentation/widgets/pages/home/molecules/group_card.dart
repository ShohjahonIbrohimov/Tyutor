import 'package:flutter/material.dart';
import 'package:moreinfo/cubit/app_menu/app_menu_cubit.dart';
import 'package:moreinfo/cubit/group/current_group_cubit.dart';
import 'package:moreinfo/data/models/groups/groups_model.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:provider/src/provider.dart';

class GroupCard extends StatelessWidget {
  GroupsModel group;

  GroupCard({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<AppMenuCubit>()
            .setCurrentTab(AppMenuCubitModel(title: 'students', route: 5));
        context.read<CurrentGroupCubit>().setCurrentGroup(group);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0.0, 1.0), //(x,y)
              blurRadius: 2.0,
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primaryColorLight,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.people_outline_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    group.studentCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              group.name,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}

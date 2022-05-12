import 'package:flutter/material.dart';
import 'package:moreinfo/cubit/add_student/add_student_cubit.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:provider/src/provider.dart';

class StudentCard extends StatelessWidget {
  String name;
  String region;
  int conditiion;
  String conditionDesc;
  int id;
  Function() onTap;

  StudentCard({
    Key? key,
    required this.name,
    required this.id,
    required this.region,
    required this.conditiion,
    required this.conditionDesc,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColorLight,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.photo_camera_front_outlined,
                      color: Colors.white60,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      region,
                      style: const TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: conditiion == 0
                      ? green
                      : conditiion == 1
                          ? darkYellow
                          : red,
                ),
                PopupMenuButton(
                  enabled: conditionDesc.isNotEmpty,
                  icon: Icon(
                    Icons.info_rounded,
                    color: conditionDesc.isNotEmpty
                        ? primaryColorLight
                        : Colors.grey,
                  ),
                  onSelected: (value) {},
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      enabled: false,
                      child: Text(
                        conditionDesc,
                        style: TextStyle(color: primaryColor),
                      ),
                      value: '0',
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

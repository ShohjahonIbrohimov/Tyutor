import 'package:flutter/material.dart';
import 'package:moreinfo/cubit/task/task_cubit.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:moreinfo/presentation/widgets/pages/homework/molecules/status_icon.dart';
import 'package:provider/src/provider.dart';

const conditionDesc =
    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a mor';

class HomeworkCard extends StatelessWidget {
  String description;
  int id;
  int? status;
  String toRoute;
  Function() onGoBack;
  HomeworkCard(
      {Key? key,
      required this.description,
      required this.id,
      this.status,
      required this.toRoute,
      required this.onGoBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          context
              .read<TaskCubit>()
              .setIsAdd(TaskCubitModel(isAdd: false, id: id));
          Navigator.pushNamed(context, toRoute).then((value) {
            onGoBack();
          });
        },
        child: Container(
          height: 50,
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
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  description,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              StatusIcon(status: status!),
            ],
          ),
        ),
      ),
    );
  }
}

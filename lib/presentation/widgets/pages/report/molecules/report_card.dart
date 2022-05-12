import 'package:flutter/material.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/config/constants.dart';

const conditionDesc =
    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a mor';

class ReportCard extends StatelessWidget {
  String name;
  String region;
  int students;
  int? condition;
  ReportCard({
    Key? key,
    required this.name,
    required this.region,
    required this.students,
    this.condition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/report_detail');
        },
        child: Container(
          constraints: BoxConstraints(minHeight: 45),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(0.0, 1.0),
                blurRadius: 2.0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              condition != null
                  ? Icon(
                      Icons.circle,
                      color: condition == 0 ? green : red,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

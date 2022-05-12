import 'package:flutter/material.dart';

class SectionDivider extends StatelessWidget {
  String title;
  SectionDivider({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
        Text(
          title,
          style: TextStyle(color: Colors.grey.shade300),
        ),
        Expanded(
          flex: 5,
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}

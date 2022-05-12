import 'package:flutter/material.dart';
import 'package:moreinfo/presentation/config/constants.dart';

class StatusIcon extends StatelessWidget {
  int status;
  StatusIcon({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return status != 1
        ? Icon(
            Icons.circle,
            color: status == 3
                ? red
                : status == 4
                    ? green
                    : Colors.orange,
          )
        : Container();
  }
}

import 'package:flutter/material.dart';
import 'package:moreinfo/presentation/common/styles/styles.dart';

class CircleIconButton extends StatelessWidget {
  IconData icon;
  Function() onPressed;
  CircleIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      child: TextButton(
        style: circleIconButtonStyle,
        child: Icon(
          icon,
          color: Colors.grey,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

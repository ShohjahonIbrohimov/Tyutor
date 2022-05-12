import 'package:flutter/material.dart';
import 'package:moreinfo/presentation/config/constants.dart';

class Loading extends StatelessWidget {
  final bool isSmall;
  const Loading({Key? key, this.isSmall = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isSmall ? 15 : 30,
      width: isSmall ? 15 : 30,
      child: CircularProgressIndicator(
        color: primaryColor,
        strokeWidth: isSmall ? 2 : 3,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:moreinfo/presentation/config/size_config.dart';

class AppContainer extends StatelessWidget {
  Widget child;
  AppContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: screenWidth(15),
        right: screenWidth(15),
        left: screenWidth(15),
      ),
      child: child,
    );
  }
}

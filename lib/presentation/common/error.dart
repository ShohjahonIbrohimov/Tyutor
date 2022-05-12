import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  String text;
  CustomError({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.86,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.red.shade400,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

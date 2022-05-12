import 'package:flutter/material.dart';
import 'package:moreinfo/presentation/config/constants.dart';

const appBarTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

var circleIconButtonStyle = TextButton.styleFrom(
  side: BorderSide(color: Colors.grey.shade300),
  shape: const CircleBorder(),
);

const defaultRadius = BorderRadius.all(Radius.circular(10));

const enabledBorderStyle = OutlineInputBorder(
  borderRadius: defaultRadius,
  borderSide: BorderSide(color: gray, width: 1.0),
);

const focusedBorderStyle = OutlineInputBorder(
  borderRadius: defaultRadius,
  borderSide: BorderSide(color: primaryColor, width: 2.0),
);

const focusedErrorBorderStyle = OutlineInputBorder(
  borderRadius: defaultRadius,
  borderSide: BorderSide(color: red, width: 2.0),
);

const inputLabelStyle = TextStyle(
  color: gray,
);

const floatingLabelStyle = TextStyle(
  color: primaryColor,
);

const errorStyle = TextStyle(color: red);

import 'package:flutter/material.dart';
import 'constants.dart';

final theme = ThemeData(
  canvasColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Muli',
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white),
  ),
  appBarTheme: const AppBarTheme(
    color: primaryColor,
    // titleTextStyle: TextStyle(color: Color(0x8B8B8B8B), fontSize: 18),
  ),
  primarySwatch: Colors.blueGrey,
);

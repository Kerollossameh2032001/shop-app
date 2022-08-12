import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color defaultColor = Colors.pink;
Color secondDefaultColor = Color.fromRGBO(0, 0, 58, 1);

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.pink,
  scaffoldBackgroundColor: Colors.blueGrey[50],
  appBarTheme: AppBarTheme(
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontStyle: FontStyle.italic,
        fontSize: 25,
      ),
      iconTheme: IconThemeData(color: Colors.black87),
      elevation: 0.0,
      backgroundColor: Colors.blueGrey[50],
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.blueGrey[50],
        statusBarIconBrightness: Brightness.dark,
      )),
);

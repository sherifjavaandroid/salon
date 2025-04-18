import 'package:flutter/material.dart';

import 'color.dart';

ThemeData themeEnglish = ThemeData(
  fontFamily: "Roboto",
  scaffoldBackgroundColor: AppColor.backgroundColor,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      height: 2,
      color: AppColor.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  ),
);

ThemeData themeArabic = ThemeData(
  fontFamily: "Roboto",
  scaffoldBackgroundColor: AppColor.backgroundColor,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      height: 2,
      color: AppColor.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  ),
);

import 'package:choose_app/presentation/constants/constants.dart';
import 'package:choose_app/presentation/utils/border_radius.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(0, minElevatedButtonHeight),
      shape: RoundedRectangleBorder(borderRadius: borderRadiusLarge),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: borderRadiusLarge),
    contentPadding: const EdgeInsets.all(20),
  ),
);

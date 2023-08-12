import 'package:choose_app/presentation/constants/constants.dart';
import 'package:choose_app/presentation/theme/app_colors.dart';
import 'package:choose_app/presentation/utils/border_radius.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(0, minElevatedButtonHeight),
      shape: RoundedRectangleBorder(borderRadius: borderRadiusMedium),
      backgroundColor: colorPrimary,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: borderRadiusMedium),
    enabledBorder: OutlineInputBorder(
      borderRadius: borderRadiusMedium,
      borderSide: const BorderSide(color: colorPrimary, width: 3),
    ),
    contentPadding: const EdgeInsets.all(20),
  ),
);

import 'package:choose_app/presentation/constants/constants.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(0, minElevatedButtonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(elevatedButtonRadius),
      ),
    ),
  ),
);

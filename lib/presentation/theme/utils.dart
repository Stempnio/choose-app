import 'package:flutter/material.dart';

extension ContextTextThemeX on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension TextThemeX on TextTheme {
  TextTheme get bold => copyWith(
        headlineLarge: headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        headlineMedium: headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        headlineSmall: headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        titleLarge: titleLarge?.copyWith(fontWeight: FontWeight.bold),
        titleMedium: titleMedium?.copyWith(fontWeight: FontWeight.bold),
        titleSmall: titleSmall?.copyWith(fontWeight: FontWeight.bold),
        bodyMedium: bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        bodySmall: bodySmall?.copyWith(fontWeight: FontWeight.bold),
        labelMedium: labelMedium?.copyWith(fontWeight: FontWeight.bold),
        labelSmall: labelSmall?.copyWith(fontWeight: FontWeight.bold),
      );
}

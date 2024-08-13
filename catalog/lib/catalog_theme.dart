import "package:flutter/material.dart";

class CatalogTheme {
  static const colorScheme = ColorScheme.light(
    primary: Color(0xFF87A0B2),
    onPrimary: Color(0xFF121212),
    secondary: Color(0xFF857885),
    onSecondary: Color(0xFF121212),
    tertiary: Color(0xFF684A52),
    onTertiary: Color(0xFFEEEEEE),
    error: Color(0xFFB33951),
    onError: Color(0xFFEEEEEE),
    surface: Color(0xFFEEEEEE),
    surfaceContainer: Color(0xFFEEEEEE),
    onSurface: Color(0xFF121212),
  );

  static const textTheme = TextTheme(
    displayLarge: TextStyle(fontFamily: "Poppins", fontSize: 57, height: 64 / 57, fontWeight: FontWeight.normal),
    displayMedium: TextStyle(fontFamily: "Poppins", fontSize: 45, height: 52 / 45, fontWeight: FontWeight.normal),
    displaySmall: TextStyle(fontFamily: "Poppins", fontSize: 36, height: 44 / 36, fontWeight: FontWeight.normal),
    headlineLarge: TextStyle(fontFamily: "Poppins", fontSize: 32, height: 40 / 32, fontWeight: FontWeight.normal),
    headlineMedium: TextStyle(fontFamily: "Poppins", fontSize: 28, height: 36 / 28, fontWeight: FontWeight.normal),
    headlineSmall: TextStyle(fontFamily: "Poppins", fontSize: 24, height: 32 / 24, fontWeight: FontWeight.normal),
    titleLarge: TextStyle(fontFamily: "Poppins", fontSize: 22, height: 28 / 22, fontWeight: FontWeight.normal),
    titleMedium: TextStyle(fontFamily: "Poppins", fontSize: 18, height: 24 / 18, fontWeight: FontWeight.normal),
    titleSmall: TextStyle(fontFamily: "Poppins", fontSize: 14, height: 20 / 14, fontWeight: FontWeight.normal),
    labelLarge: TextStyle(fontFamily: "Poppins", fontSize: 14, height: 20 / 14, fontWeight: FontWeight.normal),
    labelMedium: TextStyle(fontFamily: "Poppins", fontSize: 12, height: 16 / 12, fontWeight: FontWeight.normal),
    labelSmall: TextStyle(fontFamily: "Poppins", fontSize: 11, height: 16 / 11, fontWeight: FontWeight.normal),
    bodyLarge: TextStyle(fontFamily: "Poppins", fontSize: 16, height: 24 / 16, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontFamily: "Poppins", fontSize: 14, height: 20 / 14, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(fontFamily: "Poppins", fontSize: 12, height: 16 / 12, fontWeight: FontWeight.normal),
  );

  static const PageTransitionsTheme transitions = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}

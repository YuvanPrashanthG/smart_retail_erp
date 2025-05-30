import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF5D5FEF),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Roboto',
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF5D5FEF),
    secondary: Color(0xFF3D5AFE),
    background: Colors.white,
    surface: Color(0xFFF5F5F5),
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onBackground: Colors.black,
    onSurface: Colors.black,
    onError: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black87),
    titleLarge: TextStyle(color: Colors.black),
    labelLarge: TextStyle(color: Colors.black),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFF1F1F1),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF5D5FEF)),
    ),
    labelStyle: TextStyle(color: Colors.black),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF5D5FEF),
      foregroundColor: Colors.white,
      minimumSize: Size(double.infinity, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Color(0xFF5D5FEF)),
  ),
  iconTheme: const IconThemeData(color: Colors.black87),
  cardColor: Colors.white,
  dividerColor: Colors.grey.shade300,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF5D5FEF),
  scaffoldBackgroundColor: const Color(0xFF121212),
  fontFamily: 'Roboto',
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF5D5FEF),
    secondary: Color(0xFF3D5AFE),
    background: Color(0xFF121212),
    surface: Color(0xFF1E1E1E),
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onBackground: Colors.white,
    onSurface: Colors.white,
    onError: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF1E1E1E),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF5D5FEF)),
    ),
    labelStyle: TextStyle(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF5D5FEF),
      foregroundColor: Colors.white,
      minimumSize: Size(double.infinity, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Color(0xFF5D5FEF)),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  cardColor: Color(0xFF1E1E1E),
  dividerColor: Colors.grey.shade700,
);

import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    cardColor: Colors.black,
    primaryColor: Colors.black,
    appBarTheme: AppBarTheme(backgroundColor: Colors.black),
    dividerColor: Colors.white,
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.white,
    ),
  );
  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    primaryColor: Colors.white,
  );
}

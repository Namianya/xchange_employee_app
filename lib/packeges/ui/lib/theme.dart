import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
    //  textTheme: GoogleFonts.latoTextTheme(
    //   Theme.of(context).textTheme,
    // ),
    primaryColor: Colors.purple[800],
    cardTheme: CardTheme(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    // ignore: deprecated_member_use
    buttonColor: Colors.indigo,
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: const ButtonStyle().copyWith()),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarTextStyle: TextStyle(
        color: Colors.black,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.black,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    textTheme: TextTheme(
        bodyText2: const TextStyle().copyWith(
      fontWeight: FontWeight.bold,
    )),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.indigo));

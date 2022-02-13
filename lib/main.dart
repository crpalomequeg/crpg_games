import 'package:flutter/material.dart';
import 'package:crpg_games/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "GameApp",
      theme: ThemeData(
        // textTheme: GoogleFonts.manropeTextTheme().apply(
        //   bodyColor: Colors.white,
        // ),
          textTheme: GoogleFonts.manropeTextTheme(),
      ),
      home: HomePage(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imcapp/pages/home_page.dart';

class ImcApp extends StatelessWidget {
  const ImcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.robotoTextTheme()),
      home: const HomePage(),
      );
  }
}
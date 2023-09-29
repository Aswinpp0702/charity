import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Admin/Admin_Splash_Screen.dart';
import 'mainscreen.dart';

var uid_user;
var ip_address = "192.168.29.152";
var access_total_amt;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: GoogleFonts.robotoSlabTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: main_screen(),
    );
  }
}

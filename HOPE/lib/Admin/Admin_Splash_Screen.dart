import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hope/Admin/admin_event_registration.dart';
import 'package:hope/Admin/admin_login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Admin_home_page.dart';

var session_key;

class Admin_Splash_Screen extends StatefulWidget {
  _Admin_Splash_ScreenState createState() => _Admin_Splash_ScreenState();
}

class _Admin_Splash_ScreenState extends State<Admin_Splash_Screen> {
  void initState() {
    getValidationData().whenComplete(() async {
      await Timer(Duration(seconds: 1), () {
        session_key == null
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => admin_login()))
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Admin_home_page()));
      });
    });
    setState(() {});

    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var obtainedemail = await sharedprefs.getString('admin_get_id');
    setState(() {
      session_key = obtainedemail;
    });
    print('this is session  value $session_key');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Loading......",
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              color: Colors.lightBlue,
            ),
          ],
        ),
      ),
    );
  }
}

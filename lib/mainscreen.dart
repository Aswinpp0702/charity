import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/Admin/Admin_Splash_Screen.dart';

import 'Admin/admin_login_page.dart';

import 'User/Splashscreen_User_.dart';

class main_screen extends StatefulWidget {
  const main_screen({Key? key}) : super(key: key);

  @override
  State<main_screen> createState() => _main_screenState();
}

class _main_screenState extends State<main_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: Text(''),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Column(

          children: [
            SizedBox(height:20),

            Row(
              children: [
                SizedBox(width:20),
               // Text('WELCOME',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),
                Text('WELCOME',style: GoogleFonts.croissantOne(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey))

              ],
            ),
            //Image.asset('assets/hope.png'),
            SizedBox(height: 230),

            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    // setState(() {
                    //
                    // });

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Admin_Splash_Screen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[800],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  child: Text("ADMIN",style: TextStyle(letterSpacing: 2,fontSize: 15),)),
            ),
            SizedBox(height: 20),
             Divider(color: Colors.grey,),
            SizedBox(height: 20),



            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    // setState(() {
                    //
                    // });

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Hope_User_Splash1()));
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  child: Text("USER",style: TextStyle(letterSpacing: 2,fontSize: 15))),
            ),
          ],
        ),
      ),
    );
  }
}

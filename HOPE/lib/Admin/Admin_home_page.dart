
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hope/main.dart';
import 'package:hope/Admin/admin_event_registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Admin_Edit_Craft_item.dart';
import 'Craft_display_Edit_Page.dart';
import 'add_craft.dart';
import 'admin_cancel_food_bookings.dart';
import 'admin_delete_events.dart';
import 'admin_edit_event.dart';
import 'admin_edit_event_display.dart';
import 'admin_login_page.dart';
import 'admin_remove_craft_items.dart';
import 'craft_display.dart';
import 'view_donations.dart';
import '../User/food_donations_display_user.dart';
import 'admin_event_display.dart';
import 'package:google_fonts/google_fonts.dart';

class Admin_home_page extends StatefulWidget {
  const Admin_home_page({Key? key}) : super(key: key);

  @override
  State<Admin_home_page> createState() => _Admin_home_pageState();
}

class _Admin_home_pageState extends State<Admin_home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // backgroundColor: Colors.grey[300],
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'HOPE',
            //userid
            style: GoogleFonts.robotoSlab(
              fontSize: 20,
              //color: Colors.cyan,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.pink[400],
          elevation: 0,
          //toolbarHeight: 80,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     bottom: Radius.circular(35),
          //   ),
          // ),

        ),

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.pink,
                ),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.pink),
                  accountName: Text("Aswin"),
                  accountEmail: Text("aswin@gmail.com"),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      "A",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              // SizedBox(height:200),
              ListTile(
                leading: Icon(Icons.add),
                title: Text("Add events",style: TextStyle(letterSpacing: 1.5,fontSize: 15),),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => admin_event_registration()));
                },
              ),

              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit events",style: TextStyle(letterSpacing: 1.5,fontSize: 15),),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => admin_edit_events_display()));
                },
              ),

              ListTile(
                leading: Icon(Icons.delete),
                title: Text("Delete events",style: TextStyle(letterSpacing: 1.5,fontSize: 15),),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => admin_delete_events()));
                },
              ),

              ListTile(
                leading: Icon(Icons.edit_outlined),
                title: Text("Add crafts",style: TextStyle(letterSpacing: 1.5,fontSize: 15),),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => add_craft()));
                },
              ),

              ListTile(
                leading: Icon(Icons.edit_outlined),
                title: Text("Edit craft",style: TextStyle(letterSpacing: 1.5,fontSize: 15),),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Craft_display_Edit_Page()));
                },
              ),

              ListTile(
                leading: Icon(Icons.remove_circle),
                title: Text("Remove craft items",style: TextStyle(letterSpacing: 1.5,fontSize: 15),),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => admin_remove_craft_items()));
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text("Cancel food bookings",style: TextStyle(letterSpacing: 1.5,fontSize: 15),),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => admin_cancel_food_bookings()));
                },
              ),
              ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Log out",style: TextStyle(letterSpacing: 1.5,fontSize: 15),),
                  // onTap: () async {
                  //   final SharedPreferences sharedprefs =
                  //       await SharedPreferences.getInstance();
                  //   sharedprefs.remove("get_id");
                  //   Navigator.pushReplacement(context,
                  //       MaterialPageRoute(builder: (context) => admin_login()));
                  // }
                onTap: (){
                  Admin_Signout(context);
                },
                  ),
            ],
          ),
        ),

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        body: SingleChildScrollView(
          child: Stack(children: [
            // Positioned(
            //     child: Container(
            //       height: 330,
            //       width: 500,
            //       decoration: BoxDecoration(
            //           color: Colors.yellow,
            //           image: DecorationImage(
            //               image: AssetImage("assets/Events.png"),
            //             fit: BoxFit.fill
            //               ),
            //           borderRadius: BorderRadius.only(
            //             bottomLeft: Radius.circular(40),
            //             bottomRight: Radius.circular(40),
            //           )
            //       ),
            //       child: BackdropFilter(
            //           filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
            //         child: Container(
            //          // decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            //         ),
            //
            //       ),
            //       // child: Image.asset('assets/Events.png'),
            //     )),


            Center(
              child: Column(
                  children: [

                SizedBox(height: 100),

                Row(
                  children: [
                    Expanded(
                      child: Divider(color: Colors.grey,),
                    ),

                    Text(
                      "MONEY DONATIONS",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),

                    Expanded(
                      child: Divider(color: Colors.grey,),
                    ),

                    SizedBox(width: 20,),

                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),

                    Text(
                      "FOOD DONATIONS",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.grey,),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 150,
                          //width: 100,
                          //color: Colors.red,
                          decoration: BoxDecoration(
                              // image: DecorationImage(
                              //     image: AssetImage("assets/money donation.png"),
                              //   fit: BoxFit.contain
                              //     ),
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.grey[400],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext) =>
                                            donation()));
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/heart.png',
                                    width: 80,
                                    height: 150,
                                  )
                                ],
                              )),
                        ),
                      ),

                      SizedBox(width: 30),

                      Expanded(
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                              // image: DecorationImage(
                              //     image: AssetImage("assets/food_donation.png"),
                              //     fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.grey[400],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext) =>
                                            user_food_donation_display()));
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/tray.png',
                                    width: 80,
                                    height: 150,
                                    //fit: BoxFit.fill,
                                  ),
                                  // Text("FOOD DONATIONS",style: TextStyle(color: Colors.white),),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 13),

                Row(
                  children: [
                    Text(
                      "      EVENTS",
                      style: GoogleFonts.robotoSlab(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                Container(
                  height: 190,
                  width: 340,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/events1.png"),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white70,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext) => event_display()));
                    },

                  ),
                ),
                SizedBox(height: 20),

                Row(
                  children: [
                    Text(
                      "      CRAFTS",
                      style: GoogleFonts.robotoSlab (
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                Container(
                  height: 190,
                  width: 340,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/craft1.png"),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white70,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext) => craft_display()));
                    },
                  ),
                ),

              ]),
            ),
          ]),
        ));
  }



  Admin_Signout(BuildContext ctx) async //using navigator so we need context
      {
    final _CustomersharedPrefs = await SharedPreferences.getInstance();
    await _CustomersharedPrefs.remove('hope_adminid');
    //push new page and remove all other pages

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx1) => admin_login()),
            (route) => false);
  }
}

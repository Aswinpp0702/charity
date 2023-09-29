
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hope/User/food_bookings_cancel__user.dart';
import 'package:hope/User/Craft_display_user.dart';
import 'package:hope/User/event_CANCEL_display_user.dart';
import 'package:hope/User/event_display_user.dart';
import 'package:hope/User/event_registration_user.dart';
import 'package:hope/User/money_donate_user.dart';
import 'package:hope/User/food_bookings_user.dart';
import 'package:hope/User/money_donations_display_user.dart';
import 'package:hope/main.dart';
import 'package:hope/Admin/admin_event_registration.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Admin/add_craft.dart';
import '../Admin/craft_display.dart';
import '../Admin/view_donations.dart';
import '../User/food_donations_display_user.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Login_User.dart';
import 'My_Orders.dart';
import 'View_Cart_User.dart';
import 'cart_display_user.dart';

class User_home_page extends StatefulWidget {
  const User_home_page({Key? key}) : super(key: key);

  @override
  State<User_home_page> createState() => _User_home_pageState();
}

class _User_home_pageState extends State<User_home_page> {

  int currentindex = 0;

  final Screens =[
    Cart(),//0th position
    Payment_User(),//1 st postion

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            //'HOPE',
            'HOPE ID : ${uid_user}',
             //userid,
            style: GoogleFonts.robotoSlab(
              fontSize: 18,color: Colors.black
              //color: Colors.cyan,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
         backgroundColor: Colors.white,
          elevation: 0,
          //toolbarHeight: 130,

        ),
        drawer: Drawer(
         //backgroundColor: Colors.black54,
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  accountName: Text("Aswin", style: TextStyle(color: Colors.black),),
                  accountEmail: Text("aswin@gmail.com" ,style: TextStyle(color: Colors.black),),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Text(
                      "A",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              ListTile(
                tileColor: Colors.grey[300],

                leading: Icon(Icons.add,color: Colors.black),
                title: Text("Money Donation",style: TextStyle(letterSpacing: 1.5,color: Colors.black,fontSize: 16),),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => user_donate_money()));
                },
              ),
              SizedBox(height: 10,),

              ListTile(
                tileColor: Colors.grey[300],

                leading: Icon(Icons.add,color: Colors.black),
                title: Text("Food Bookings",style: TextStyle(letterSpacing: 1.5,color: Colors.black,fontSize: 16),),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => user_food_bookings()));
                },
              ),

              SizedBox(height: 10,),

              ListTile(
                tileColor: Colors.grey[300],

                leading: Icon(Icons.add,color: Colors.black),
                title: Text("Event Registration",style: TextStyle(letterSpacing: 1.5,color: Colors.black,fontSize: 16),),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => user_event_registration()));
                },
              ),
              SizedBox(height: 10,),

              ListTile(
                tileColor: Colors.grey[300],

                leading: Icon(Icons.cancel,color: Colors.black),
                title: Text("Cancel Events",style: TextStyle(letterSpacing: 1.5,color: Colors.black,fontSize: 16),),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => user_event_CANCEL_display()));
                },
              ),
              SizedBox(height: 10,),
              ListTile(
                tileColor: Colors.grey[300],

                leading: Icon(Icons.cancel,color: Colors.black),
                title: Text("Cancel food bookings",style: TextStyle(letterSpacing: 1.5,color: Colors.black,fontSize: 16),),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => user_cancel_food_bookings()));
                },
              ),
              SizedBox(height: 10,),

              ListTile(
                tileColor: Colors.grey[300],

                leading: Icon(Icons.remove_red_eye_sharp,color: Colors.black),
                title: Text("View Cart",style: TextStyle(letterSpacing: 1.5,color: Colors.black,fontSize: 16),),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Viewcart_User()));
                },
              ),
              SizedBox(height: 10,),
              ListTile(
                tileColor: Colors.grey[300],

                leading: Icon(Icons.cancel,color: Colors.black),
                title: Text("Cancel order of cart products",style: TextStyle(letterSpacing: 1.5,color: Colors.black,fontSize: 16),),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => user_cancel_food_bookings()));
                },
              ),


              SizedBox(height: 10,),

              ListTile(
                  tileColor: Colors.grey[300],
                  leading: Icon(Icons.logout,color: Colors.black,),
                  title: Text("My Orders",style: TextStyle(letterSpacing: 1.5,color: Colors.black,fontSize: 16),),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => My_Orders()));
                  }),

              SizedBox(height: 10,),

              ListTile(
                  tileColor: Colors.grey[300],
                  leading: Icon(Icons.logout,color: Colors.black,),
                  title: Text("Log out",style: TextStyle(letterSpacing: 1.5,color: Colors.black,fontSize: 16),),
                  onTap: () async {
                    final SharedPreferences sharedprefs =
                        await SharedPreferences.getInstance();
                    sharedprefs.remove("hope_userid");
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Hope_user_Login()));
                  }),
            ],
          ),
        ),

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        body: SingleChildScrollView(
          child: Column(
              children: [
            Center(
              child: Column(children: [
                SizedBox(height: 150),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "MONEY DONATIONS",
                      style: GoogleFonts.hindVadodara(
                        fontSize: 17,
                        color: Colors.blue[300],
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "FOOD DONATIONS",
                      style: GoogleFonts.hindVadodara(
                        fontSize: 17,
                        color: Colors.red,
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
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue[300],
                             ),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext) =>
                                            user_view_money_donation()));
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
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red[500],
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
                                    'assets/food.png',
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
                SizedBox(height: 30,),
                Divider(
                  color: Colors.pink,thickness: 3,
                ),

                SizedBox(height: 30,),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "EVENTS",
                      style: GoogleFonts.hindVadodara(
                        fontSize: 17,
                        color: Colors.yellow[700],
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "CRAFTS",
                      style: GoogleFonts.hindVadodara(
                        fontSize: 17,
                        color: Colors.green[400],
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
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.yellow[700],
                          ),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext) =>
                                            user_event_display()));
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/calender.png',
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
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.green[400],
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
                                            user_craft_display()));
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/watercolor.png',
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
              ]),
            ),
              // Screens[currentindex],

          ]),
       ),


    );
  }
}


class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}

class Payment_User extends StatefulWidget {
  const Payment_User({Key? key}) : super(key: key);

  @override
  State<Payment_User> createState() => _Payment_UserState();
}

class _Payment_UserState extends State<Payment_User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

    );
  }
}


import 'dart:async';
import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'User_home_page.dart';
import 'Login_User.dart';





class Hope_User_Splash1 extends StatefulWidget {
  _Hope_User_Splash1State createState() => _Hope_User_Splash1State();
}

class _Hope_User_Splash1State extends State<Hope_User_Splash1> {

  void initState() {
    checkHopeUserLoogedIn();
    setState(() {
      Get_id();
    });

    super.initState();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
  }


    // Timer(
    //   Duration(seconds: 2),
    //       () => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyLogin())),
    // );


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,


      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.pink.shade300,
            strokeWidth: 5,
          ),
          SizedBox(height: 20,),
          Text(
            "Fetching all the details....",
            style: GoogleFonts.aclonica(
              color: Colors.pink.shade300,
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],


      ),
    );
  }
  Future HopeUser_gotoLogin() async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Hope_user_Login()));
  }

  //
  // old code -> Future<void> checkHopeUserLoogedIn() async{
  //   final _Hope_AdminsharedPrefs =await SharedPreferences.getInstance();
  //   print(Hope_user_Key);
  //   final _merchantLoggedIn=_Hope_AdminsharedPrefs.getBool(Hope_user_Key);
  //   if(_merchantLoggedIn == null || _merchantLoggedIn == false){
  //     HopeUser_gotoLogin();
  //   }
  //   else{
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Hope_User_Dashboard()));
  //   }
  //
  // }

  Future<void> checkHopeUserLoogedIn() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    // print("first key check "+Customer_Key);
    final _hope_user_userid = _sharedPrefs.getString("hope_userid");

    if (_hope_user_userid == null) {
      HopeUser_gotoLogin();
    }
    else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => User_home_page()));
    }
  }

  Future Get_id()async{
    final _sharedPrefs = await SharedPreferences.getInstance();
    final obtain_id = _sharedPrefs.getString("Get_userid");
    setState(() {
      uid_user =obtain_id;
    });
  }



}
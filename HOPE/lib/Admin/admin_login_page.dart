import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope/Admin/admin_event_registration.dart';
import 'package:hope/mainscreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_registration_page.dart';
import 'Admin_home_page.dart';
import '../main.dart';




class admin_login extends StatefulWidget {
  const admin_login({Key? key}) : super(key: key);

  @override
  State<admin_login> createState() => _admin_loginState();
}

class _admin_loginState extends State<admin_login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    username = TextEditingController();
    password = TextEditingController();

    super.initState();
  }


  // getId()async {
  //   final sharedprefs = await SharedPreferences.getInstance();
  //   await sharedprefs.setString("setid",userid);
  // }

  Future Login() async {

    var url = "http://192.168.29.152/charity_HOPE/admin_login.php";

    var response = await http.post(Uri.parse(url), headers:{
      'Accept': 'application/json'
    },
        body:{
          "username": username.text,
          "password": password.text
        });

    var data = json.decode(response.body);


    if(data!=null){
      for (var SingleUser in data){
        final SharedPreferences sharedPreferences =await SharedPreferences.getInstance();

        await sharedPreferences.setString("admin_get_id", SingleUser["id"]);

        // userid = SingleUser["username"];
        //
        // getId();
      }

      final snackBar =SnackBar(
          content: Text("login successfully"),
          action : SnackBarAction(
              label: 'OK',
              onPressed: (){}));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (BuildContext context)=> Admin_home_page()));
    }
    else{
      final snackBar =SnackBar(
          content: Text("invalid password"),
          action : SnackBarAction(
              label: 'OK',
              onPressed: (){}));
    }


  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>main_screen()));
          }, icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.black,

      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: 250),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                  controller: username,
                  decoration: InputDecoration(
                      fillColor: Colors.grey,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'Username',
                    //labelText: 'Username, email address or mobile number',
                  )),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                    fillColor: Colors.grey,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'Password',

                  )),
            ),
            // SizedBox(height: ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Login();

                    });


                  },
                  style: ElevatedButton.styleFrom(
                    //backgroundColor: Colors.brown[600],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text("Login")),
            ),

            Center(child: Text("Are you a new user?",style: TextStyle(color:Colors.grey,))),

            SizedBox(height: 80),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => admin_registration()));
                  },

                  child: Text("Register")),
            ),
          ],
        ),
      ),
    );
  }
}

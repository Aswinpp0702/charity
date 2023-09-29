import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hope/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'User_home_page.dart';
import 'Registration_User.dart';




class Hope_user_Login extends StatefulWidget {
  const Hope_user_Login({Key? key}) : super(key: key);

  @override
  _Hope_user_LoginState createState() => _Hope_user_LoginState();
}

class _Hope_user_LoginState extends State<Hope_user_Login> {
  TextEditingController hope_user_user = TextEditingController();
  TextEditingController Hope_user_pass = TextEditingController();
  final GlobalKey<FormState> user_formkey = GlobalKey<FormState>();

  Get_uid()async{


    final _UserrsharedPrefs = await SharedPreferences.getInstance();
    await _UserrsharedPrefs.setString("Get_userid",uid_user );

  }



  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
      //   image: DecorationImage(
      //       image: AssetImage('assets/images/log.png'), fit: BoxFit.cover),
       ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.black, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: user_formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: hope_user_user,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter username";
                                }
                                return null;
                              },
                              onSaved: (name) {},
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Username",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: Hope_user_pass,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter password";
                                }
                                return null;
                              },
                              onSaved: (name) {},
                              style: TextStyle(),
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {

                                        });
                                        Hope_User_Login();

                                        if (user_formkey.currentState!.validate()) {
                                          print("Successfully  logged");
                                          hope_user_user.clear();
                                          Hope_user_pass.clear();
                                        }
                                      }),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    //Navigator.pushNamed(context, 'register');
                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>Hope_Ad_Registration()));
                                  },
                                  child: Text(
                                    'Does not have an account?',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      // decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 17),
                                  ),
                                  style: ButtonStyle(),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Hope_User_Registration()));
                                    },
                                    child: Text(
                                      //  'Forgot Password',
                                      'Sign Up',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future Hope_User_Login() async {
    //var url ="https://anthracitic-pecks.000webhostapp.com/Hope_Charity_Project/Admin/Hope_Admin_Login.php"; //intego wifi password
    var url ="http://$ip_address/charity_HOPE/user_login.php";
    var response = await http.post(Uri.parse(url),
        headers: {
          'Accept':'application/json'
        },

        body: {
          "username": hope_user_user .text,
          "password": Hope_user_pass.text,
        });
    var data = json.decode(response.body);
    // if (data.toString() == "Success") {
    if (data!=null) {
      //var responseData = json.decode(response.body);


      for (var singleUser in data) {


        print(singleUser["id"]);


        uid_user=singleUser["id"];

        final _UserrsharedPrefs = await SharedPreferences.getInstance();
        // await _CustomersharedPrefs.setBool(Customer_Key, true);
        await _UserrsharedPrefs.setString("hope_userid", singleUser["id"]);

        uid_user=singleUser["id"];
        Get_uid();

        // print(response);
        //Customer_Key=singleUser["id"];
        //print("key:"+Customer_Key);
      }

      final snackBar = SnackBar(
        content: Text('Login Successfull'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // final _CustomersharedPrefs = await SharedPreferences.getInstance();
      // // await _CustomersharedPrefs.setBool(Customer_Key, true);
      // await _CustomersharedPrefs.setInt("userid", data["id"]);


      Navigator.push(
          context, MaterialPageRoute(builder: (context) => User_home_page()));
      print("username:");
      // Customer_Key=data["id"];
      //print(data["id"]);
      // print(Customer_Key);
      // print(data);


    } else {
      final snackBar = SnackBar(
        content: Text('Username and password invalid'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }}
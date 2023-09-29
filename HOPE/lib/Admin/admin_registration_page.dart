import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class admin_registration extends StatefulWidget {
  const admin_registration({Key? key}) : super(key: key);

  @override
  State<admin_registration> createState() => _admin_registrationState();
}

class _admin_registrationState extends State<admin_registration> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  late bool status;
  late String message;

  @override
  void initState() {
    // TODO: implement initState
    username = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    confirm_password = TextEditingController();

    status = false;
    message = "";
    super.initState();
  }

  Future Submit() async {

    var APIURL = "http://192.168.29.152/charity_HOPE/admin_registration.php";

    Map maped_data = {
      'username': username.text,
      'email': email.text,
      'phone': phone.text,
      'password': password.text,
    };
    http.Response response = await http.post(Uri.parse(APIURL), body: maped_data);

    var data = jsonDecode(response.body);
    var responsemessage = data["message"];
    var responseerror=data["error"];

    if(responseerror){
      setState(() {
        status =false;
        message=responsemessage;
      });
    }
    else{
      username.clear();
      password.clear();
      phone.clear();
      email.clear();
      confirm_password.clear();

      setState(() {
        status =true;
        message =responsemessage;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(height: 130),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                      controller: username,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please enter username";
                        }
                        return null;},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Username',
                        //labelText: 'Username, email address or mobile number',
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                      controller: email,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter email";
                        }
                        if (!RegExp("^[a-ZA-ZO-9+_.-]+@[a-zA-ZO-9+.-]+.[a-z]").hasMatch(value)) {
                          return "Please enter a valid email";
                        }
                        return null;

                      },
                      onSaved: (email) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'email',
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                      controller: phone,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if(value!.length!=10){
                          return "Please enter a valid phone number";
                        }
                        return null;},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Phone',
                        //labelText: 'Username, email address or mobile number',
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                      controller: password,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please enter password";
                        }
                        return null;},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Password',
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                      controller: confirm_password,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please re-enter the password";
                        }
                        if(password.text!=confirm_password.text){
                          return "Password do not match";
                        }
                        return null;},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Confirm Password',
                      )),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if(formkey.currentState!.validate()){
                          setState(() {
                            Submit();
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      child: Text("Register")),
                ),

                Text(status ? message : message),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

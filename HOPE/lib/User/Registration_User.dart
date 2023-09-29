import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../main.dart';

class Hope_User_Registration extends StatefulWidget {
  const Hope_User_Registration({Key? key}) : super(key: key);

  @override
  _Hope_User_RegistrationState createState() => _Hope_User_RegistrationState();
}

class _Hope_User_RegistrationState extends State<Hope_User_Registration> {
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  late bool status;
  late String message;

  @override
  void initState() {
    _username = TextEditingController();
    _email = TextEditingController();
    _phone = TextEditingController();
    _password = TextEditingController();
    _confirmpassword = TextEditingController();

    status = false;
    message = "";

    super.initState();
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/image3.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 35, top: 20),
                child: Text(
                  'Create\nAccount',
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.20),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _username,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter name";
                                  }
                                  return null;
                                },
                                onSaved: (name) {},
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Username",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _email,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter  email";
                                  }
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return "Please enter valid email";
                                  }
                                  return null;
                                },
                                onSaved: (email) {},
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _phone,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter  phone";
                                  }
                                  if (value.length < 9) {
                                    return "Please enter valid phone";
                                  }
                                  return null;
                                },
                                onSaved: (phone) {},
                                style: TextStyle(color: Colors.white),
                                obscureText: true,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "phone",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _password,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter password";
                                  }

                                  return null;
                                },
                                style: TextStyle(color: Colors.white),
                                obscureText: true,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "password",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _confirmpassword,
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter re-password";
                                  }
                                  if (_password.text != _confirmpassword.text) {
                                    return "Password Do not match";
                                  }
                                  return null;
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "confirm password",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 27,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xff4c505b),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward,
                                      ),
                                      color: Colors.white,
                                      onPressed: () {
                                        if (_formkey.currentState!.validate()) {
                                          setState(() {
                                            RegistrationUser();
                                          });
                                          // RegistrationUser();
                                          print("Successful");
                                          _username.clear();
                                          _phone.clear();
                                          _password.clear();
                                          _email.clear();
                                          _confirmpassword.clear();
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                              Text(status ? message : message),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future RegistrationUser() async {
    var APIURL ="http://$ip_address/charity_HOPE/user_registration.php";
        //"https://anthracitic-pecks.000webhostapp.com/Hope_Charity_Project/Admin/Hope_Admin_Registration.php";

    //json maping user entered details
    Map mapeddate = {
      'username': _username.text,
      'email': _email.text,
      'phone': _phone.text,
      'password': _password.text
    };
    //send  data using http post to our php code
    http.Response reponse = await http.post(Uri.parse(APIURL), body: mapeddate);

    //getting response from php code, here
    var data = jsonDecode(reponse.body);
    var responseMessage = data["message"];
    var responseError = data["error"];
    print("DATA: ${data}");
    if (responseError) {
      setState(() {
        status = false;
        message = responseMessage;
      });
    } else {
      _username.clear();
      _email.clear();
      _phone.clear();
      _password.clear();
      _confirmpassword.clear();

      setState(() {
        status = true;
        message = responseMessage;
      });
    }

    print("DATA: ${data}");
  }
}

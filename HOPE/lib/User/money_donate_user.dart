import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hope/User/money_donations_display_user.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class user_donate_money extends StatefulWidget {
  const user_donate_money({Key? key}) : super(key: key);

  @override
  State<user_donate_money> createState() => _user_donate_moneyState();
}

class _user_donate_moneyState extends State<user_donate_money> {
  TextEditingController name = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController bank = TextEditingController();
  TextEditingController account = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  late bool status;
  late String message;

  @override
  void initState() {
    // TODO: implement initState
    name = TextEditingController();
    place = TextEditingController();
    phone = TextEditingController();
    amount = TextEditingController();
    bank = TextEditingController();
    account = TextEditingController();
    status = false;
    message = "";
    super.initState();
  }

  Future Submit() async {
    var APIURL = "http://$ip_address/charity_HOPE/user_money_donation.php";

    Map maped_data = {
      'name': name.text,
      'place': place.text,
      'phone': phone.text,
      'amount': amount.text,
      'bank': bank.text,
      'account': account.text,
    };
    http.Response response =
    await http.post(Uri.parse(APIURL), body: maped_data);

    var data = jsonDecode(response.body);
    var responsemessage = data["message"];
    var responseerror = data["error"];

    if (responseerror) {
      setState(() {
        status = false;
        message = responsemessage;
      });
    } else {
      name.clear();
      place.clear();
      phone.clear();
      amount.clear();
      bank.clear();
      account.clear();

      setState(() {
        status = true;
        message = responsemessage;
      });

      Fluttertoast.showToast(
          msg: "send successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.blueGrey,
          timeInSecForIosWeb: 1);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('DONATE',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),


      ),
      body: Center(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: [
                SizedBox(height:10),

                TextFormField(
                  controller: name,
                  maxLines: 1,
                  decoration:InputDecoration(
                    // fillColor: Colors.grey[400],
                    // filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    labelText: 'Name',
                    prefixIcon:  Icon(Icons.perm_identity),
                  ),
                ),
                SizedBox(height:18),

                TextFormField(
                    controller: place,
                    decoration: InputDecoration(
                      // fillColor: Colors.grey[400],
                      // filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'place',
                      prefixIcon:  Icon(Icons.access_time),

                      //labelText: 'Username, email address or mobile number',
                    )),
                SizedBox(height:18),


                TextFormField(
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      // fillColor: Colors.grey[400],
                      // filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'phone',
                      prefixIcon:  Icon(Icons.phone_android),
                    )),
                SizedBox(height:18),

                TextFormField(
                    controller: amount,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      // fillColor: Colors.grey[400],
                      // filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'amount',
                      prefixIcon:  Icon(Icons.attach_money),
                    )),
                SizedBox(height:18),

                TextFormField(
                    controller: bank, decoration: InputDecoration(
                  // fillColor: Colors.grey[400],
                  // filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'bank',
                      prefixIcon:  Icon(Icons.comment_bank),
                    )),
                SizedBox(height:18),

                TextFormField(
                    controller: account,
                    decoration: InputDecoration(
                      // fillColor: Colors.grey[400],
                      // filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'account',
                      prefixIcon:  Icon(Icons.description),
                    )),
                SizedBox(height:65),



                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Submit();
                        name.clear();
                        place.clear();
                        phone.clear();
                        amount.clear();
                        bank.clear();
                        account.clear();
                      });

                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => login()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),),
                      minimumSize: Size(350, 38),

                    ),
                    child: Text("Submit")),
                Center(child: Text(status ? message : message,style: TextStyle(color: Colors.blueGrey),)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

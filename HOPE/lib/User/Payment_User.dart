import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hope/User/event_display_user.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'View_Cart_User.dart';

class Payment_User extends StatefulWidget {
  var cart_data;

  Payment_User({required this.cart_data});


  @override
  State<Payment_User> createState() => _Payment_UserState();
}

class _Payment_UserState extends State<Payment_User> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController bank = TextEditingController();
  TextEditingController ac_no = TextEditingController();
  TextEditingController total_amt = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  late bool status;
  late String message;

  @override
  void initState() {
    // TODO: implement initState
    name = TextEditingController();
    phone = TextEditingController();
    bank = TextEditingController();
    ac_no = TextEditingController();
    total_amt = TextEditingController(text: widget.cart_data);
    // uid = TextEditingController(text: "admin");
    status = false;
    message = "";
    super.initState();
  }

  Future Submit() async {
    var APIURL = "http://$ip_address/charity_HOPE/payment.php";

    Map maped_data = {
      'name': name.text,
      'phone': phone.text,
      'bank': bank.text,
      'ac_no': ac_no.text,
      'total_amt': total_amt.text,
      'uid': uid_user,
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
      phone.clear();
      bank.clear();
      ac_no.clear();
      total_amt.clear();

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
        title: Text('Payment',style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),


      ),
      body: Center(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                SizedBox(height:10),
                TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      // fillColor: Colors.grey[400],
                      // filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Name',
                      prefixIcon:  Icon(Icons.emoji_events),

                      //labelText: 'Username, email address or mobile number',
                    )),
                SizedBox(height:15),
                TextFormField(
                 keyboardType: TextInputType.number,
                  controller: phone,
                  maxLines: 1,
                  decoration:InputDecoration(
                    // fillColor: Colors.grey[400],
                    // filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    labelText: 'Phone',
                    prefixIcon:  Icon(Icons.phone),
                  ),
                ),
                SizedBox(height:15),

                TextFormField(
                    controller: bank,
                    decoration: InputDecoration(
                      // fillColor: Colors.grey[400],
                      // filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Bank',
                      prefixIcon:  Icon(Icons.account_balance),

                      //labelText: 'Username, email address or mobile number',
                    )),
                SizedBox(height:15),


                TextFormField(
                    controller: ac_no,
                    keyboardType: TextInputType.number,

                    // maxLines: 4,
                    decoration: InputDecoration(
                      // fillColor: Colors.grey[400],
                      // filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Account_number',
                      prefixIcon:  Icon(Icons.supervisor_account),
                    )),
                SizedBox(height:15),

                TextFormField(
                    controller: total_amt,
                    keyboardType: TextInputType.number,

                    //maxLines: 4,
                    decoration: InputDecoration(
                      // fillColor: Colors.grey[400],
                      // filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Total amount',
                      prefixIcon:  Icon(Icons.attach_money_outlined),
                    )),

                SizedBox(height:40),

                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Submit();
                        name.clear();
                        phone.clear();
                        bank.clear();
                        ac_no.clear();
                        total_amt.clear();
                      });

                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => login()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      minimumSize: Size(350, 38),

                    ),
                    child: Text("Submit")),
                Center(child: Text(status ? message : message,style: TextStyle(color: Colors.blueGrey))),
                // Text(widget.datapass.craft_id)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

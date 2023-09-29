import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class user_food_bookings extends StatefulWidget {
  const user_food_bookings({Key? key}) : super(key: key);

  @override
  State<user_food_bookings> createState() => _user_food_bookingsState();
}

class _user_food_bookingsState extends State<user_food_bookings> {
  TextEditingController date = TextEditingController();
  TextEditingController donor = TextEditingController();
  TextEditingController food = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  late bool status;
  late String message;

  @override
  void initState() {
    // TODO: implement initState
    date = TextEditingController();
    donor = TextEditingController();
    food = TextEditingController();
    status = false;
    message = "";
    super.initState();
  }

  Future Submit() async {
    var APIURL = "http://$ip_address/charity_HOPE/user_food_donation_bookings.php";

    Map maped_data = {
      'date': date.text,
      'donor': donor.text,
      'food': food.text,
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
      date.clear();
      donor.clear();
      food.clear();

      setState(() {
        status = true;
        message = responsemessage;
      });

      Fluttertoast.showToast(
          msg: "send successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blueGrey,
          timeInSecForIosWeb: 1);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Food Bookings',style: TextStyle(color: Colors.black),),
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
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                SizedBox(height:30),
                TextFormField(
                  onTap: () async {
                    DateTime? Pickdate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2024));
                    if (Pickdate != null) {
                      setState(() {
                        date.text = DateFormat('dd/MM/yyyy').format(Pickdate);
                      });
                    }
                  },keyboardType: TextInputType.number,
                  controller: date,
                  maxLines: 1,
                  decoration:InputDecoration(
                    // fillColor: Colors.grey[400],
                    // filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    hintText: 'DD/MM/YYYY',
                    labelText: 'Booking date',
                    prefixIcon:  Icon(Icons.calendar_today),
                  ),
                ),
                SizedBox(height:18),

                TextFormField(
                    controller: donor,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      // fillColor: Colors.grey[400],
                      // filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Donor',
                      prefixIcon:  Icon(Icons.account_circle),

                      //labelText: 'Username, email address or mobile number',
                    )),
                SizedBox(height:18),


                TextFormField(
                    controller: food,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      // fillColor: Colors.grey[400],
                      // filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Food',
                      prefixIcon:  Icon(Icons.fastfood_outlined),
                    )),
                SizedBox(height:60),

                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Submit();
                        date.clear();
                        donor.clear();
                        food.clear();
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
                Center(child: Text(status ? message : message,style: TextStyle(color: Colors.blueGrey),)),
                SizedBox(height: 30,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

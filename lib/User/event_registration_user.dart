import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hope/User/event_display_user.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class user_event_registration extends StatefulWidget {
  const user_event_registration({Key? key}) : super(key: key);

  @override
  State<user_event_registration> createState() => _user_event_registrationState();
}

class _user_event_registrationState extends State<user_event_registration> {
  TextEditingController event_name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController description = TextEditingController();
  // TextEditingController uid = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  late bool status;
  late String message;

  @override
  void initState() {
    // TODO: implement initState
    event_name = TextEditingController();
    date = TextEditingController();
    time = TextEditingController();
    description = TextEditingController();
    // uid = TextEditingController(text: "admin");
    status = false;
    message = "";
    super.initState();
  }

  Future Submit() async {
    var APIURL = "http://$ip_address/charity_HOPE/user_event_registration.php";

    Map maped_data = {
      'name': event_name.text,
      'event_date': date.text,
      'event_time': time.text,
      'description': description.text,
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
      event_name.clear();
      date.clear();
      time.clear();
      description.clear();

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
        title: Text('Event registration',style: TextStyle(color: Colors.black)),
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
                    controller: event_name,
                    decoration: InputDecoration(
                      // fillColor: Colors.grey[400],
                      // filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Event name',
                      prefixIcon:  Icon(Icons.emoji_events),

                      //labelText: 'Username, email address or mobile number',
                    )),
                SizedBox(height:15),
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
                    labelText: 'Event date',
                    prefixIcon:  Icon(Icons.calendar_today),
                  ),
                ),
                SizedBox(height:15),

                TextFormField(
                    controller: time,
                    decoration: InputDecoration(
                      // fillColor: Colors.grey[400],
                      // filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Event time',
                      prefixIcon:  Icon(Icons.access_time),

                      //labelText: 'Username, email address or mobile number',
                    )),
                SizedBox(height:15),


                TextFormField(
                    controller: description,
                    maxLines: 4,
                    decoration: InputDecoration(
                      // fillColor: Colors.grey[400],
                      // filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Description',
                      prefixIcon:  Icon(Icons.description),
                    )),
                SizedBox(height:15),

                // TextFormField(
                //     controller: uid,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(12)),
                //       labelText: 'Uid',
                //       prefixIcon:  Icon(Icons.perm_identity_outlined),
                //     )),

                SizedBox(height:40),

                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Submit();
                        event_name.clear();
                        date.clear();
                        time.clear();
                        description.clear();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

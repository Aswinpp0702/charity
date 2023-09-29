import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_event_display.dart';
import '../main.dart';

class admin_event_registration extends StatefulWidget {
  const admin_event_registration({Key? key}) : super(key: key);

  @override
  State<admin_event_registration> createState() => _admin_event_registrationState();
}

class _admin_event_registrationState extends State<admin_event_registration> {
  TextEditingController event_name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController uid = TextEditingController();

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
    uid = TextEditingController(text: "admin");
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
      'uid': uid.text,
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
      uid.clear();

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
      appBar: AppBar(
        title: Text('Event registration'),
        centerTitle: true,

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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Event name',
                      prefixIcon:  Icon(Icons.emoji_events),

                      //labelText: 'Username, email address or mobile number',
                    )),
                SizedBox(height:15),
                TextField(
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Event time',
                      prefixIcon:  Icon(Icons.access_time),

                      //labelText: 'Username, email address or mobile number',
                    )),
                SizedBox(height:15),


                TextFormField(
                    controller: description,
                    maxLines: 7,
                    decoration: InputDecoration(
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
                        uid.clear();
                      });

                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => login()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: Text("Submit")),
                Text(status ? message : message),
                SizedBox(height: 30,),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => event_display()));
                    },style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                    child: Text("Display data")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

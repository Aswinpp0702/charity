import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/User/Craft_display_user.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class User_View_craft_shop_Detail_Page extends StatefulWidget {
  final Craft_model_User data_craft_user;

  const User_View_craft_shop_Detail_Page({required this.data_craft_user});

  @override
  _User_View_craft_shop_Detail_PageState createState() =>
      _User_View_craft_shop_Detail_PageState();
}

class _User_View_craft_shop_Detail_PageState
    extends State<User_View_craft_shop_Detail_Page> {
  TextEditingController crt_id = new TextEditingController();
  TextEditingController uid = new TextEditingController();
  TextEditingController qty = new TextEditingController();

  late bool status;
  late String message;

  Future<void> access_id() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      final ui = _sharedPrefs.getString("Get_userid");
      //uid_user =ui!;
      if (uid_user == null) {
        uid_user = ui!;
      }
    });
  }

  @override
  void initState() {
    crt_id = TextEditingController(text: widget.data_craft_user.craft_id);
    uid = TextEditingController();
    qty = TextEditingController(text: "1");

    status = false;
    message = "";

    super.initState();
  }

  Future<void> submitData() async {
    var send = await http.post(
        Uri.parse("http://$ip_address/charity_HOPE/user_add_to_cart.php"),
        body: {
          //"id": widget.data_craft.id.toString(),
          "craft_id": widget.data_craft_user.craft_id,
          "uid": uid_user,
          "qty": qty.text,
        });

    if (send.statusCode == 200) {
      var data = json.decode(send.body);
      var responseMessage = data["message"];
      var responseError = data["error"];
      if (responseError) {
        setState(() {
          status = false;
          message = responseMessage;
        });
      } else {
        crt_id.clear();
        uid.clear();

        setState(() {
          status = true;
          message = responseMessage;
        });
      }
    } else {
      setState(() {
        message = "Error:Server error";
        status = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.data_craft_user.name.toUpperCase(), style: TextStyle(color: Colors.black,fontSize:25,),),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(children: [
            SizedBox(height: 50),

            Image.network(widget.data_craft_user.image),
            SizedBox(height: 35),

            Divider(
              color: Colors.grey,
            ),
            SizedBox(height: 50),

            Row(
              children: [
                SizedBox(width: 30),

                Text(
                  widget.data_craft_user.name.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 30),
                ),
               SizedBox(width: 200),
                Text('\$',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.red)),

                Text(widget.data_craft_user.price,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.red)),
                SizedBox(width: 15),

                Icon(Icons.favorite),

              ],
            ),
            SizedBox(height: 100),


            ElevatedButton(
                onPressed: () {
                  setState(() {
                    print(widget.data_craft_user.craft_id);
                    print("${uid_user}");
                  });
                  submitData();
                },
                style: ElevatedButton.styleFrom(
                 // backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(350, 43),
                ),
                child: Text("ADD TO CART"))
          ]),
        ));
  }
}

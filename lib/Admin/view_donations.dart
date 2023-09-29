import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User_model{
  final String id;
  final String name;
  final String place;
  final String phone;
  final String amount;
  final String bank;
  final String account;

  User_model( {
    required this.id, required this.name, required this.place,required this.phone,required this.amount
    ,required this.bank,required this.account
  });
}

class donation extends StatefulWidget {
  const donation({Key? key}) : super(key: key);

  @override
  State<donation> createState() => _donationState();
}

class _donationState extends State<donation> {
  //http://localhost/charity_HOPE/admin_donation_display.php
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donations'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 190,
                width: 150,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage(""), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      )
                    ]),
              ),
              Container(
                height: 190,
                width: 150,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage(""), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      )
                    ]),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 190,
                width: 150,
                decoration: BoxDecoration(
                    image:
                    DecorationImage(image: AssetImage(""), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      )
                    ]),
              ),
              Container(
                height: 190,
                width: 150,
                decoration: BoxDecoration(
                    image:
                    DecorationImage(image: AssetImage(""), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      )
                    ]),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 190,
                width: 150,
                decoration: BoxDecoration(
                    image:
                    DecorationImage(image: AssetImage(""), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      )
                    ]),
              ),
              Container(
                height: 190,
                width: 150,
                decoration: BoxDecoration(
                    image:
                    DecorationImage(image: AssetImage(""), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      )
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

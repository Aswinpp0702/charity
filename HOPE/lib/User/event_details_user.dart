import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class user_event_details extends StatefulWidget {
  var datapass;

  user_event_details({required this.datapass});

  @override
  State<user_event_details> createState() => _user_event_detailsState();
}

class _user_event_detailsState extends State<user_event_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            children: [
              Container(
                child: Column(
                children: [
                  SizedBox(height: 200),
                  Text(
                    widget.datapass.name,
                    style: GoogleFonts.aBeeZee(color: Colors.brown[200], fontSize: 35),
                  ),
                  SizedBox(height: 90),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Date:',
                        style: GoogleFonts.aBeeZee(
                            color: Colors.brown[200], fontSize: 20),
                      ),

                      Text(widget.datapass.event_date,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.brown[200])),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //SizedBox(width: 1),

                      Text(
                        'Time:',
                        style: GoogleFonts.aBeeZee(
                            color: Colors.brown[200], fontSize: 20),
                      ),
                      Text(widget.datapass.event_time,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.brown[200])),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Description:',
                        style: GoogleFonts.aBeeZee(
                            color: Colors.brown[200], fontSize: 20),
                      ),
                      Text(widget.datapass.description,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.brown[200])),
                    ],
                  ),
                ],
              ),)
            ],
          ),
        ));
  }
}

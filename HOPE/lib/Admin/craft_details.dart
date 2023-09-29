import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class craft_details extends StatefulWidget {
  var datapass;

  craft_details({required this.datapass});

  @override
  State<craft_details> createState() => _craft_detailsState();
}

class _craft_detailsState extends State<craft_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [

            Positioned(
                child: Container(
                  height: 900,
                  color: Colors.yellow[600],
                )),

            Positioned(
              top: 250,
                child: Container(
                  height: 900,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0)),
                    color: Colors.white,

                  ),


            )),
            Positioned(
              top: 150,
              right: 100,
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.datapass.image),
                radius: 100,foregroundColor: Colors.yellow,
              ),
            ),
            // Container(
            //   child: Image.network(widget.datapass.image),
            // ),

           // Text(widget.datapass.name,style: GoogleFonts.aBeeZee(color: Colors.brown),),
            // Positioned(
            //   top: 420,
            //   left: 178,
            //   child: Text(widget.datapass.price,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
            // ),
            Column(
              children: [

                SizedBox(
                  height: 380,
                  width: 500,
                ),
                Text(widget.datapass.name,style: GoogleFonts.aBeeZee(color: Colors.brown),),
                SizedBox(height:10),
                // Text('\$'),


                Text(widget.datapass.price,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              ],
            )
          ]
        ));
  }
}

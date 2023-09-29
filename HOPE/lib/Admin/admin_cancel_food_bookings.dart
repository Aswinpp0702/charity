import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'admin_edit_event.dart';
import '../main.dart';


class food_model{
  final String id;
  final String date;
  final String donor;
  final String food;
  final String uid;

  food_model( {
    required this.id,
    required this.date,
    required this.donor,
  required this.food,
    required this.uid,
  });
}

class admin_cancel_food_bookings extends StatefulWidget {
  const admin_cancel_food_bookings({Key? key}) : super(key: key);

  @override
  State<admin_cancel_food_bookings> createState() => _admin_cancel_food_bookingsState();
}

class _admin_cancel_food_bookingsState extends State<admin_cancel_food_bookings> {

  Future<List<food_model>>getRequest() async{
    String url = "http://$ip_address/charity_HOPE/Admin_Display_Food_Donations.php";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);


    List<food_model> users = [



    ];

    for(var singleUser in responseData){
      food_model user = food_model(
          id: singleUser["id"].toString(),
          date: singleUser["donor"].toString(),
          food: singleUser["food"].toString(),
          uid: singleUser["uid"].toString(),
          donor: singleUser["donor"].toString());


      users.add(user);
    }
    return users;


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cancel Food Bookings"),
      ),
      body: Container(
        child: FutureBuilder(
          future: getRequest(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.data == null){
              return Container(
                child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator()
                    ],
                  ),
                ),
              );
            }
            else{
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (ctx,index)=>Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18,top: 10,right: 18),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.brown[100],
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ListTile(
                                // shape: RoundedRectangleBorder(
                                //   side: BorderSide(
                                //     width: 1,
                                //     color: Colors.black
                                //   ),
                                //     borderRadius: BorderRadius.circular(50)
                                // ),
                                title: Text(snapshot.data[index].donor),
                                subtitle: Text(snapshot.data[index].date),
                                trailing: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      delrecord(snapshot.data[index].id);
                                    //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>admin_cancel_food_bookings()));
                                    });


                                  },
                                  child: Icon(Icons.delete),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),

              );
            }
          },

        ),
      ),
    );
  }


//////////////////////////////////////////////////   DELETE   //////////////////////////////////////////////////////////////////////

  Future<void>delrecord(String id) async{
    String url = "http://$ip_address/charity_HOPE/admin_delete_food_bookings.php";
    var res = await http.post(Uri.parse(url),body:{
      "id":id });
    var response = jsonDecode(res.body);
    if(response["success"]=="true"){
      print("success");
    }
  }
}








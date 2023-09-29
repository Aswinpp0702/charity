import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hope/User/event_details_user.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';


class User_model{
  final String id;
  final String date;
  final String donor;
  final String food;

  User_model( {
    required this.id, required this.date, required this.donor,required this.food,
  });
}

class user_cancel_food_bookings extends StatefulWidget {
  const user_cancel_food_bookings({Key? key}) : super(key: key);

  @override
  State<user_cancel_food_bookings> createState() => _user_cancel_food_bookingsState();
}

class _user_cancel_food_bookingsState extends State<user_cancel_food_bookings> {

  Future<List<User_model>>getRequest() async{

    final shrdprfs = await SharedPreferences.getInstance();
    final ui = shrdprfs.getString("hope_userid");

    String url = "http://$ip_address/charity_HOPE/cancel_food_bookings.php?uid="+ui!;
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);


    List<User_model> users = [



    ];

    for(var singleUser in responseData){
      User_model user = User_model(
          id: singleUser["id"].toString(),
          date: singleUser["date"].toString(),
          donor: singleUser["donor"].toString(),
          food: singleUser["food"].toString());



      users.add(user);
    }
    return users;


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("CANCEL FOOD BOOKINGS",style: TextStyle(color: Colors.white),),
        //centerTitle: true,
        backgroundColor: Colors.black12,

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
                      padding: const EdgeInsets.only(left: 18,top: 20,right: 18),
                      child: InkWell(
                        // onTap: () {
                        //   Navigator.push(context, MaterialPageRoute(
                        //       builder: (BuildContext) => user_event_details(datapass: snapshot.data[index])));
                        // },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: Colors.brown[100],
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ListTile(
                                  title: Center(child: Text(snapshot.data[index].food)),
                                  subtitle: Center(child: Text(snapshot.data[index].date)),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        delrecord(snapshot.data[index].id);
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>user_cancel_food_bookings()));
                                      });


                                    },
                                    child: Icon(Icons.delete),
                                  ),
                                ),
                              )
                            ],
                          ),
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
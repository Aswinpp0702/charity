import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'admin_edit_event.dart';
import '../main.dart';


class User_model{
   final String id;
   final String name;
   final String event_date;
   final String event_time;
   final String description;
   final String uid;

   User_model( {
     required this.id, required this.name, required this.event_date,required this.event_time,required this.description
     ,required this.uid,
});
}

class event_display extends StatefulWidget {
  const event_display({Key? key}) : super(key: key);

  @override
  State<event_display> createState() => _event_displayState();
}

class _event_displayState extends State<event_display> {

  Future<List<User_model>>getRequest() async{
    String url = "http://$ip_address/charity_HOPE/admin_event_display.php";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);

    
    List<User_model> users = [
     
      
      
    ];
    
    for(var singleUser in responseData){
      User_model user = User_model(
          id: singleUser["id"].toString(), 
          name: singleUser["name"].toString(),
          event_date: singleUser["event_date"].toString(),
          event_time: singleUser["event_time"].toString(),
          description: singleUser["description"].toString(),
          uid: singleUser["uid"].toString());

      
      users.add(user);
    }
    return users;


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
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
                                  title: Center(child: Text(snapshot.data[index].name)),
                                  subtitle: Center(child: Text(snapshot.data[index].event_date)),

                                  // leading: GestureDetector(
                                  //   onTap: (){
                                  //     setState(() {
                                  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>admin_edit_events(
                                  //           data_user: snapshot.data[index])));
                                  //     });
                                  //   },
                                  //   child: Icon(Icons.edit),
                                  // ),
                                  //
                                  //
                                  // subtitle: Text(snapshot.data[index].event_date),
                                  // trailing: GestureDetector(
                                  //   onTap: () {
                                  //     setState(() {
                                  //      delrecord(snapshot.data[index].id);
                                  //      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>event_display()));
                                  //     });
                                  //
                                  //
                                  //   },
                                  //   child: Icon(Icons.delete),
                                  // ),
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


}








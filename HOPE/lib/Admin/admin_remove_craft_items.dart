import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'Admin_Edit_Craft_item.dart';
import 'admin_edit_event.dart';
import '../main.dart';
import 'craft_details.dart';



class Craft_model_edit_display{
  final String id;
  final String name;
  final String craft_id;
  final String price;
  final String description;
  final String image;

  Craft_model_edit_display( {
    required this.id, required this.name, required this.craft_id,required this.price,required this.description
    ,required this.image,
  });
}

class admin_remove_craft_items extends StatefulWidget {
  const admin_remove_craft_items({Key? key}) : super(key: key);

  @override
  State<admin_remove_craft_items> createState() => _admin_remove_craft_itemsState();
}

class _admin_remove_craft_itemsState extends State<admin_remove_craft_items> {

  Future<List<Craft_model_edit_display>>getRequest() async{
    String url = "http://$ip_address/charity_HOPE/admin_craft_display.php";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);


    List<Craft_model_edit_display> users = [



    ];

    for(var singleUser in responseData){
      Craft_model_edit_display user = Craft_model_edit_display(
          id: singleUser["id"].toString(),
          name: singleUser["name"].toString(),
          craft_id: singleUser["craft_id"].toString(),
          price: singleUser["price"].toString(),
          description: singleUser["description"].toString(),
          image: singleUser["image"].toString());


      users.add(user);
    }
    return users;


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Craft"),
        elevation: 0,
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
                    // SizedBox(height:10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,top: 10,right: 20),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.brown[100],
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ListTile(
                            title: Text(snapshot.data[index].name),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data[index].image),
                            ),


                            subtitle: Text(snapshot.data[index].craft_id),
                            trailing: GestureDetector(
                              onTap: () {
                                setState(() {
                                  delrecord(snapshot.data[index].id);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>admin_remove_craft_items()));
                                });


                              },
                              child: Icon(Icons.delete),
                            ),
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
    String url = "http://$ip_address/charity_HOPE/admin_craft_delete.php";
    var res = await http.post(Uri.parse(url),body:{
      "id":id });
    var response = jsonDecode(res.body);
    if(response["success"]=="true"){
      print("success");
    }
  }
}








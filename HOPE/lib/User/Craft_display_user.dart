import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../Admin/craft_details.dart';
import '../Admin/craft_display.dart';
import '../main.dart';
import 'Craft_Shop_detail_page_User.dart';



class Craft_model_User{
  final String id;
  final String name;
  final String craft_id;
  final String price;
  final String description;
  final String image;

  Craft_model_User( {
    required this.id, required this.name, required this.craft_id,required this.price,required this.description
    ,required this.image,
  });
}

class user_craft_display extends StatefulWidget {
  const user_craft_display({Key? key}) : super(key: key);

  @override
  State<user_craft_display> createState() => _user_craft_displayState();
}

class _user_craft_displayState extends State<user_craft_display> {

  Future<List<Craft_model_User>>getRequest() async{
    String url = "http://$ip_address/charity_HOPE/admin_craft_display.php";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);


    List<Craft_model_User> users = [



    ];

    for(var singleUser in responseData){
      Craft_model_User user = Craft_model_User(
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
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text("CRAFTS",style: TextStyle(color: Colors.black),),
        //centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),


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
                      padding: const EdgeInsets.only(left: 15,top: 20,right: 15),
                      child: Container(
                        decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(30),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              )
                            ]
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ListTile(
                                  title: Text(snapshot.data[index].name),
                                  leading: Image.network(snapshot.data[index].image),


                                  subtitle: Text(snapshot.data[index].craft_id),
                                  trailing: IconButton(
                                     onPressed: () {
                                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>user_craft_details(datapass: snapshot.data[index])));
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>User_View_craft_shop_Detail_Page(data_craft_user: snapshot.data[index])));

                                     }, icon: Icon(Icons.arrow_forward_ios)
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

  // Future<void>delrecord(String id) async{
  //   String url = "http://$ip_address/charity_HOPE/admin_craft_delete.php";
  //   var res = await http.post(Uri.parse(url),body:{
  //     "id":id });
  //   var response = jsonDecode(res.body);
  //   if(response["success"]=="true"){
  //     print("success");
  //   }
  // }
}








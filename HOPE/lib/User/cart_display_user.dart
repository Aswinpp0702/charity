import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Admin/craft_details.dart';
import '../Admin/craft_display.dart';
import '../main.dart';
import 'Craft_Shop_detail_page_User.dart';



class Cart_model_User{
  final String id;
  final String craft_id;
  final String cid;
  final String qty;
  final String name;
  final String price;
  final String description;
  final String image;

  Cart_model_User( {
    required this.id,
    required this.craft_id,
    required this.cid,
    required this.qty,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });
}

class user_cart_display extends StatefulWidget {
  const user_cart_display({Key? key}) : super(key: key);

  @override
  State<user_cart_display> createState() => _user_cart_displayState();
}

class _user_cart_displayState extends State<user_cart_display> {

  Future<List<Cart_model_User>>getRequest() async{
    final shrdprfs = await SharedPreferences.getInstance();
    final ui = shrdprfs.getString("hope_userid");


    String url = "http://$ip_address/charity_HOPE/user_view_cart.php?uid="+ui!;
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);


    List<Cart_model_User> users = [



    ];

    for(var singleUser in responseData){
      Cart_model_User user = Cart_model_User(
          id: singleUser["id"].toString(),
          craft_id: singleUser["craft_id"].toString(),
          cid: singleUser["cartid"].toString(),
          qty: singleUser["qty"].toString(),
          name: singleUser["name"].toString(),
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
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: Text("CART"
            ""),
        //centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,

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
                      padding: const EdgeInsets.only(left: 20,top: 20,right: 20),
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
                                title: Text(snapshot.data[index].name),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot.data[index].image),
                                ),


                                subtitle: Text(snapshot.data[index].price),
                                trailing: IconButton(
                                   onPressed: () {
                                     setState(() {
                                       delrecord(snapshot.data[index].cid);
                                       Navigator.pushReplacement(context, MaterialPageRoute(
                                           builder: (context)=>user_cart_display()));
                                     });

                                   }, icon: Icon(Icons.delete)
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

  Future<void>delrecord(String id) async{
    String url = "http://$ip_address/charity_HOPE/user_remove_cart_items.php";
    var res = await http.post(Uri.parse(url),body:{
      "id":id });
    var response = jsonDecode(res.body);
    if(response["success"]=="true"){
      print("success");
    }
  }
}








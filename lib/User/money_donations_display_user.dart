import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hope/User/event_details_user.dart';

import 'package:http/http.dart' as http;
import '../main.dart';


class User_model{
  final String id;
  final String name;
  final String place;
  final String phone;
  final String amount;
  final String bank;
  final String account;

  User_model( {
    required this.id,
    required this.name,
    required this.place,
    required this.phone,
    required this.amount,
    required this.bank,
    required this.account,
  });
}

class user_view_money_donation extends StatefulWidget {
  const user_view_money_donation({Key? key}) : super(key: key);

  @override
  State<user_view_money_donation> createState() => _user_view_money_donationState();
}

class _user_view_money_donationState extends State<user_view_money_donation> {

  Future<List<User_model>>getRequest() async{
    String url = "http://$ip_address/charity_HOPE/admin_donation_display.php";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);


    List<User_model> users = [



    ];

    for(var singleUser in responseData){
      User_model user = User_model(
          id: singleUser["id"].toString(),
          name: singleUser["name"].toString(),
          place: singleUser["place"].toString(),
          phone: singleUser["phone"].toString(),
          amount: singleUser["amount"].toString(),
          bank: singleUser["bank"].toString(),
          account: singleUser["account"].toString());


      users.add(user);
    }
    return users;


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("DONATIONS",style: TextStyle(color: Colors.white),),
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
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(
                          //     builder: (BuildContext) => user_event_details(datapass: snapshot.data[index])));
                        },
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
                                  // shape: RoundedRectangleBorder(
                                  //   side: BorderSide(
                                  //     width: 1,
                                  //     color: Colors.black
                                  //   ),
                                  //     borderRadius: BorderRadius.circular(50)
                                  // ),
                                  title: Center(child: Text(snapshot.data[index].name)),
                                  // leading: GestureDetector(
                                  //   onTap: (){
                                  //     setState(() {
                                  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>edit_data(
                                  //           data_user: snapshot.data[index])));
                                  //     });
                                  //   },
                                  //   child: Icon(Icons.edit),
                                  // ),


                                  subtitle: Center(child: Text(snapshot.data[index].amount)),
                                  // trailing: GestureDetector(
                                  //   onTap: () {
                                  //     setState(() {
                                  //      delrecord(snapshot.data[index].id);
                                  //      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>user_event_display()));
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

//   Future<void>delrecord(String id) async{
//     String url = "http://$ip_address/charity_HOPE/admin_delete_event.php";
//     var res = await http.post(Uri.parse(url),body:{
//       "id":id });
//     var response = jsonDecode(res.body);
//     if(response["success"]=="true"){
//       print("success");
//     }
//   }
}
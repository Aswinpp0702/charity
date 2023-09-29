import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'admin_event_display.dart';
import '../main.dart';


class admin_edit_events extends StatefulWidget {
  final User_model data_user;

  admin_edit_events({required this.data_user});

  //const edit_data({Key? key}) : super(key: key);

  @override
  State<admin_edit_events> createState() => _admin_edit_eventsState();
}

class _admin_edit_eventsState extends State<admin_edit_events> {

  TextEditingController name = TextEditingController();
  TextEditingController event_date = TextEditingController();
  TextEditingController event_time = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController uid = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Submit() async {
    final response = await http.post(Uri.parse("http://$ip_address/charity_HOPE/admin_edit_event.php"),
        body: {
      "id":widget.data_user.id.toString(),
      "name":name.text,
      "event_date":event_date.text,
      "event_time":event_time.text,
      "description":description.text,
      "uid":uid.text

        });

    if (response.statusCode==200){
      print("Data send");
      name.clear();
      event_date.clear();
      event_time.clear();
      description.clear();
      uid.clear();
      final snackBar = await SnackBar(
        content: Text("Data updated successfully"),
        action: SnackBarAction(
          label: 'ok',
          onPressed: (){},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else{
      final snackBar = await SnackBar(
        content: Text("Not updated"),
        action: SnackBarAction(
          label: '',
          onPressed: (){},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    name = TextEditingController(text: widget.data_user.name);
    event_date = TextEditingController(text: widget.data_user.event_date);
    event_time = TextEditingController(text: widget.data_user.event_time);
    //place = TextEditingController(text: widget.data_user.place);
    super.initState();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(height: 50,),


              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'name',
                      //labelText: 'Username, email address or mobile number',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                    controller: event_date,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'event_date',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                    controller: event_time,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'event_date',
                    )),
              ),

              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Submit();
                      name.clear();
                      event_date.clear();
                      event_time.clear();
                      description.clear();
                      uid.clear();
                    });

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => login()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text("Submit")),

              SizedBox(height: 30,),


              ElevatedButton(onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => event_display()));
              },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text("Display data")),

            ],
          ),
        ),
      ),

    );
  }

  }


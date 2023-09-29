import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../main.dart';


class add_craft extends StatefulWidget {
  @override
  _add_craftState createState() => _add_craftState();
}

class _add_craftState extends State<add_craft> {
  var _image;
//  final picker = ImagePicker();
  ImagePicker picker = ImagePicker();

  TextEditingController name = TextEditingController();
  TextEditingController craft_id = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future choose_image_gallery() async {
    try {
      //final image = await picker.getImage(source: ImageSource.camera);

      final image = await picker.pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this._image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future choose_image_camera() async {
    try {
      //final image = await ImagePicker.pickImage(source: ImageSource.camera);
     //final image = await picker.pickImage(source: ImageSource.camera);
      final image = await ImagePicker.platform.pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this._image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future uploadImage() async {
    final uri = Uri.parse(
        "http://$ip_address/charity_HOPE/admin_add_craft_item.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['craft_id'] = craft_id.text;
    request.fields['name'] = name.text;
    request.fields['price'] = price.text;
    request.fields['description'] = description.text;
    var pic = await http.MultipartFile.fromPath("image", _image.path);
    request.files.add(pic);
    var response = await request.send();
    print(response);

    if (response.statusCode == 200) {
      print('Image Uploded');
      price.clear();
      name.clear();


      final snackBar = await SnackBar(
        content: const Text('data send Successfully!'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print('Image Not Uploded');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "CRAFTS",
          style: GoogleFonts.aBeeZee(color: Colors.brown),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded, color: Colors.brown[300],
            //size: 35, // add custom icons also
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: name,
                  keyboardType: TextInputType.text,
                  //style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        // borderSide: BorderSide(
                        //   color: Colors.black,
                        // ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      labelText: 'name',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon:  Icon(Icons.toys_outlined),


                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: craft_id,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintText: "craft_id",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon:  Icon(Icons.account_circle_outlined),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: price,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      labelText: "Enter price",
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon:  Icon(Icons.attach_money),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18.0),
                child: TextFormField(
                  controller: description,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                         // color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintText: "description",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon:  Icon(Icons.note_add),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Choose Image",
                    style: GoogleFonts.hindVadodara(
                      fontSize: 20,
                      color: Colors.brown[300],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.photo_outlined,
                      size: 35,
                      color: Colors.brown[400],
                    ),
                    onPressed: () {
                      choose_image_gallery();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 35,
                      color: Colors.brown[400],
                    ),
                    onPressed: () {
                    choose_image_camera();
                    },
                  ),
                ],
              ),
              Center(
                child: Container(
                    height: 100,
                    width: 200,
                    //decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),  color: Colors.grey,
                    //),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: _image != null
                          ? Image.file(
                              _image,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Text(
                              "No image selected",
                              style: GoogleFonts.hindVadodara(
                                  fontSize: 13, color: Colors.red.shade600),
                            )),
                    )),
              ),
              SizedBox(height: 15),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Colors.brown,
                  padding: EdgeInsets.only(
                      left: 100, right: 100, top: 15, bottom: 15),
                ),
                onPressed: () {
                  setState(() {});
                  uploadImage();
                },
                child: Text('Submit'),
              ),

              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

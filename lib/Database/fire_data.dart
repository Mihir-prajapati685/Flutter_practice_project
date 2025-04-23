import 'dart:io';

import 'package:authentication_app/Database/login_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class fire_base extends StatefulWidget {
  @override
  State<fire_base> createState() => fire_base_data();
}

class fire_base_data extends State<fire_base> {
  var email_val = TextEditingController();
  var pass_val = TextEditingController();
  var user_val = TextEditingController();
  File? imghai;
  CollectionReference collRef = FirebaseFirestore.instance.collection(
    'flutter_data',
  );

  void storedata() async {
    var email = email_val.text;
    var password = pass_val.text;
    var username = user_val.text;
    var images = imghai!.toString();

    if (email.isNotEmpty && password.isNotEmpty) {
      QuerySnapshot querySnapshot =
          await collRef.where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("email already exist")));
      } else {
        collRef.add({
          'username': username,
          'email': email,
          'password': password,
          'image': images,
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => loginData()),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("please enter both feild")));
    }
  }
  Imagefunction(ImageSource imagesource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imagesource);
      if (photo == null) {
        return;
      } else {
        final fliepath = File(photo.path);
        setState(() {
          imghai = fliepath;
        });
      }
    } catch (ex) {
      print('here is exception $ex');
    }
  }

  opencontainer() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Image From"),
          content: Column(
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Camera"),
                onTap: () {
                  Imagefunction(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.browse_gallery),
                title: Text("Gallery"),
                onTap: () {
                  Imagefunction(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Register Page",
              style: TextStyle(color: Colors.black87, fontSize: 35),
            ),
            InkWell(
              child:
                  imghai != null
                      ? CircleAvatar(
                        backgroundImage: FileImage(imghai!),
                        radius: 70,
                      )
                      : CircleAvatar(
                        child: Icon(Icons.person, size: 50),
                        radius: 70,
                      ),
              onTap: () {
                opencontainer();
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: user_val,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.email),
                labelText: "enter the Username",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: email_val,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.email),
                labelText: "enter the Email",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: pass_val,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.password),
                labelText: "enter the password",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                storedata();
              },
              child: Text('Verify'),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

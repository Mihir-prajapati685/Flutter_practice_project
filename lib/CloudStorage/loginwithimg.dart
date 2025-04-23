import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class loginwithimg extends StatefulWidget{
  @override
  State<loginwithimg> createState()=>Login_with_img();
}
class Login_with_img extends State<loginwithimg>{
  var emailController=TextEditingController();
  var passwordContoller=TextEditingController();
  File? imgpathtype;
  opencontainer() {
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Image From"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text("Camera"),
              onTap: (){
                 PickerImg(ImageSource.camera);
                 Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.browse_gallery),
              title: Text("gallery"),
              onTap: (){
                PickerImg(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    });
  }
  PickerImg(ImageSource imagesource)async{
    try{
      final photo=await ImagePicker().pickImage(source: imagesource);
      if(photo==null){return;}
      else{
        final imgpath=File(photo.path);
        setState(() {
          imgpathtype=imgpath;
        });
      }
    }catch(err){
      print("your err is $err");
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: imgpathtype!=null?
            CircleAvatar(
              backgroundImage: FileImage(imgpathtype!),
              radius: 80,
            ):
            CircleAvatar(child: Icon(Icons.person,size: 60,),radius: 50,),
            onTap: (){
              opencontainer();
            },
          ),
          SizedBox(height: 20,),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.email),
                labelText: "enter the email",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(25),
                )
            ),
          ),
          SizedBox(height: 20,),
          TextField(
            controller: passwordContoller,
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.password),
                labelText: "enter the password",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(25),
                )
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){}, child: Text("Verify")),
        ],
      ),
    );
  }
}

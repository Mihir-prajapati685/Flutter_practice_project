import 'package:authentication_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginData extends StatefulWidget{
  @override
  State<loginData> createState()=>Login_data();
}
class Login_data extends State<loginData>{
  var email_login=TextEditingController();
  var pass_login=TextEditingController();
  CollectionReference collref=FirebaseFirestore.instance.collection('flutter_data');
  void getlogindata() async{
    var email=email_login.text;
    var password=pass_login.text;
    if(email.isNotEmpty && password.isNotEmpty){
      QuerySnapshot querySnapshot_email=await collref.where('email',isEqualTo: email).get();
      QuerySnapshot querySnapshot_pass=await collref.where('email',isEqualTo: email).get();

      if(querySnapshot_pass.docs.isNotEmpty && querySnapshot_email.docs.isNotEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successfully')));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'hurry')));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('email and password not mathch')));
      }
    }
  }
   @override
  Widget build(BuildContext context){
     return Scaffold(
       appBar: AppBar(

       ),
       body: Center(
         child:Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text("Login Page",style: TextStyle(color: Colors.black87,fontSize: 35),),
             TextField(
               controller: email_login,
               decoration: InputDecoration(
                   suffixIcon: Icon(Icons.email),
                   labelText: "enter the Email",
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
               controller: pass_login,
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
             ElevatedButton(onPressed: (){
               getlogindata();
             }, child: Text('Verify')),
           ],
         ),
       ),
     );
   }
}
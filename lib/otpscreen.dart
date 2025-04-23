import 'dart:math';
import '';
import 'package:authentication_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class otpscreen extends StatefulWidget {
  String VerificationId;
  otpscreen({super.key, required this.VerificationId});
  @override
  State<otpscreen> createState() => otp_screen();
}

class otp_screen extends State<otpscreen> {
  var otp_control = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("hii")),
      body: Column(
        children: [
          TextField(
            controller: otp_control,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "enter the number",
              suffixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async{
              try {
                var phoneauth = await PhoneAuthProvider.credential(
                  verificationId: widget.VerificationId,
                  smsCode: otp_control.text.toString(),
                );
                FirebaseAuth.instance.signInWithCredential(phoneauth).then((value)=>{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "here is your main page")))
                });
              } catch (ex) {
                 print("aapka PhoneAuth sahi nai hai $ex");
              }
            },
            child: Text('Verify'),
          ),
        ],
      ),
    );
  }
}

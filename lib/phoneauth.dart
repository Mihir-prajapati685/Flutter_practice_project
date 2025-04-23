import 'package:authentication_app/otpscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class phoneauth extends StatefulWidget {
  @override
  State<phoneauth> createState() => Phone_auth();
}

class Phone_auth extends State<phoneauth> {
  var textvalue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: textvalue,
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
            onPressed: () async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: textvalue.text.toString(),
                verificationCompleted: (PhoneAuthCredential credential) {},
                verificationFailed: (FirebaseAuthException ex) {
                  print("Verification Failed: ${ex.message}");
                },
                codeSent: (String verificationId, int? resendToken) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => otpscreen(VerificationId: verificationId)),
                  );
                },
                codeAutoRetrievalTimeout: (String verificationId) {},
                // forceResendingToken: resendToken, // Ensure reCAPTCHA is triggered
              );
            },
            child: Text('Verify'),
          ),
        ],
      ),
    );
  }
}

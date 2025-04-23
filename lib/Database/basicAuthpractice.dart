import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BasicColoectionApp extends StatefulWidget {
  @override
  State<BasicColoectionApp> createState() => _BasicColoectionApp();
}

class _BasicColoectionApp extends State<BasicColoectionApp> {
  var emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(controller: emailcontroller),
          Container(
            child: ElevatedButton(
              onPressed: () {
                postingData();
              },
              child: Text("click me"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> postingData() async {
    var email = emailcontroller.text.toString();
    CollectionReference collref = FirebaseFirestore.instance.collection('');
    QuerySnapshot querySnapshot =
        await collref.where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('already exist')));
    } else {
      collref.add({
       
      });
    }
  }
}

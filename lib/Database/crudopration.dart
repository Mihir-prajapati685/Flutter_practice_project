import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Crudopration extends StatefulWidget {
  @override
  State<Crudopration> createState() => _Crudopration();
}

class _Crudopration extends State<Crudopration> {
  var id = TextEditingController();
  CollectionReference collref = FirebaseFirestore.instance.collection('');
  Future<void> createData() async {
    try {
      await collref.add({
        'email': "mihirprajapati@gmail.com",
        'password': '1234567',
        'created_at': Timestamp.now(),
      });
    } catch (e) {
      print('error in data create $e');
    }
  }
  
  Future<void> readData() async {
    try {
      QuerySnapshot querySnapshot = await collref.get();
      if (querySnapshot.docs.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('get data sucessfully')));
      }
    } catch (e) {
      print("error in read data $e");
    }
  }

  Future<void> updateData(String id) async {
    try {
      await collref.doc(id).update({
        'email': "mihihihihih@gmail.com",
        'password': "456787654",
      });
    } catch (e) {
      print('error in updating data $e');
    }
  }

  Future<void> deleteData(String id) async {
    try {
      await collref.doc(id).delete();
    } catch (e) {
      print('error in updating data $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  createData();
                },
                child: Text('Create'),
              ),
              ElevatedButton(
                onPressed: () {
                  readData();
                },
                child: Text('Read'),
              ),
              TextField(controller: id),
              ElevatedButton(
                onPressed: () {
                  updateData(id.text);
                },
                child: Text('Update'),
              ),
              ElevatedButton(
                onPressed: () {
                  deleteData(id.text);
                },
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

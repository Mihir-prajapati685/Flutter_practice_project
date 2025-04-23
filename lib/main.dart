import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:authentication_app/CloudStorage/loginwithimg.dart';
import 'package:authentication_app/Database/fire_data.dart';
import 'package:authentication_app/Database/forprofile.dart';
import 'package:authentication_app/phoneauth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: fire_base(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String imageprofie = '';
  String? firebaseImageUrl;

  @override
  void initState() {
    super.initState();
    profilefunction();
  }

  profilefunction() async {
    DocumentSnapshot userdata = await FirebaseFirestore.instance
        .collection("flutter_data")
        .doc('flutterproject_d5d95')
        .get();

    if (userdata.exists && userdata['image'] != null) {
      String filepath = userdata['image'];

      if (kIsWeb) {
        // Web case: treat as URL from Firebase Storage
        setState(() {
          firebaseImageUrl = filepath;
        });
      } else {
        // Mobile/Desktop case: treat as local file path
        if (await File(filepath).exists()) {
          setState(() {
            imageprofie = filepath;
          });
        } else {
          print("image not found");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Home page"),
      ),
      body: Center(
        child: InkWell(
          child: kIsWeb
              ? (firebaseImageUrl != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(firebaseImageUrl!),
                      radius: 50,
                    )
                  : const CircleAvatar(
                      child: Icon(Icons.person),
                    ))
              : (imageprofie.isNotEmpty
                  ? CircleAvatar(
                      backgroundImage: FileImage(File(imageprofie)),
                      radius: 50,
                    )
                  : const CircleAvatar(
                      child: Icon(Icons.person),
                    )),
          onTap: () {
            ForProfile();
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ForProfile extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          CircleAvatar(),
          SizedBox(height: 20,),
          Text("mihir"),
          SizedBox(height: 20,),
          Text("12345"),
          SizedBox(height: 20,),
          Text("password"),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(height: MediaQuery.of(context).size.height*0.3,),
          Center(child: Image.asset("assets/logo.png"),),
          SizedBox(height: 20,),
          Center(child: Text("OH! Snap", 
          style:TextStyle(
            color:Colors.red,
            fontStyle: FontStyle.italic,
            fontSize: 20.0
          )
          ),
          ),
          Center(child: Text("Please check your internet connection.", 
          style:TextStyle(
            color:Colors.white,
            fontStyle: FontStyle.normal,
            fontSize: 16.0
          ),
          ),),
        ],
      ),
    );
  }
}
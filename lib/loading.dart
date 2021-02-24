import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*0.3,
            ),
            Image.asset("assets/logo.png"),
            SizedBox(height:20.0),
            SpinKitFoldingCube(
              color: Colors.red,

            )  
          ],
        ),
      ),
    );
  }
}
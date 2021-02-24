import 'package:flutter/material.dart';
import 'package:muvizone/home.dart';
import 'package:connectivity/connectivity.dart';
import 'package:muvizone/nonet.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
bool internet=true;

@override
  void initState() {
    super.initState();
    checkInternet();
  }

checkInternet() async{
  var connectivityResult = await (Connectivity().checkConnectivity());
if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
  setState(() {
    internet=true;
  });
}else{
  setState(() {
    internet=false;
  });
}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: internet? Home() : NoInternet(),
      theme: ThemeData(
        textTheme: TextTheme(
          body1: TextStyle(),
          body2: TextStyle(),
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}


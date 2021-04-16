import 'package:flutter/material.dart';
import 'package:milk_register/screens/home.dart';
import 'package:milk_register/screens/selector.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Home(),
        initialRoute: 'home',
        routes: {
          'home': (context) => Home(),
          'select':(context)=> SelectMilk()

        }
    );


  }
}
import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'Login.dart';

void main() => runApp(MyApp());

// Root
class MyApp extends StatelessWidget {

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Login(),
    );
  }
}

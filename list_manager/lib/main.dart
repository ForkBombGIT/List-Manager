import 'package:flutter/material.dart';
import 'homepage.dart';

void main() => runApp(ListManager());

class ListManager extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'String Beans',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(title: 'String Beans'),
    );
  }
}

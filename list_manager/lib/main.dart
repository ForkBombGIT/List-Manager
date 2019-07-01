import 'package:flutter/material.dart';
import 'homepage.dart';

void main() => runApp(ListManager());

class ListManager extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Manager',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(title: 'List Manager'),
    );
  }
}

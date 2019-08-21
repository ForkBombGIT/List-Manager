import 'package:flutter/material.dart';
import 'package:list_manager/homepage.dart';

void main() => runApp(ListManager());

class ListManager extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'String Beans',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(color: Colors.white)
      ),
      home: HomePage(title: 'String Beans'),
    );
  }
}

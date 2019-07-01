import 'package:flutter/material.dart';
import 'newlist.dart';
import 'listobject.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ListObject> lists = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: 
      Row(
        children: <Widget>[
          Expanded(
            child: Padding (
              padding: EdgeInsets.symmetric(vertical: 25.0),
              child: _buildComponent(lists)
            ),
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewList()),
          );
        },
        tooltip: 'Create a List',
        child: Icon(Icons.add),
      ),
    );
  }  
}

Widget _buildComponent(List content) {
  if (content.length == 0) return Text('Create some lists!', textAlign: TextAlign.center, style: TextStyle(fontSize: 24.0));
  return null;
}
import 'package:flutter/material.dart';

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

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              child: Text('Create some lists!', textAlign: TextAlign.center, style: TextStyle(fontSize: 24.0))
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

class NewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a List"),
        leading: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(null),
        ),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.check),
            onPressed: () => Navigator.of(context).pop(null),
          )
        ],
      ),
      body: 
      Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: TextFormField(
            decoration: new InputDecoration(
              labelText: 'List Name'
            ),
          ),
        ),
      ),
    );
  }
}
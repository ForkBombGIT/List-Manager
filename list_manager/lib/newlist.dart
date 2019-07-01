import 'package:flutter/material.dart';
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
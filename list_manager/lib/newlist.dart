import 'package:flutter/material.dart';
import 'package:list_manager/listobject.dart';
class NewList extends StatelessWidget {
  final TextEditingController listNameController = new TextEditingController();
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
            onPressed: () =>{ _createNewList(context) }
          )
        ],
      ),
      body: 
      Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: TextFormField(
            controller: listNameController,
            decoration: new InputDecoration(
              labelText: 'List Name'
            ),
          ),
        ),
      ),
    );
  }

  _createNewList(BuildContext ctx) {
    Navigator.of(ctx).pop(new ListObject(listNameController.text, new List()));
  }
}

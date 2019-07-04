import 'package:flutter/material.dart';
import 'package:list_manager/listobject.dart';

class NewList extends StatelessWidget {
  final TextEditingController listNameController = new TextEditingController();
  final TextEditingController listDescriptionController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
            onPressed: () { _createNewList(context); }
          )
        ],
      ),
      body: 
      Form(
        key:_formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                validator:  (value) {
                  if (value.isEmpty)
                    return 'List Name can\'t be left empty';
                  return null;
                },
                controller: listNameController,
                decoration: new InputDecoration(
                  labelText: 'List Name'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                controller: listDescriptionController,
                decoration: new InputDecoration(
                  labelText: 'List Description'
                ),
              ),
            ),
          ],
        )
      )
    );
  }

  _createNewList(BuildContext ctx) {
    if (_formKey.currentState.validate()) {
      String name = listNameController.text,
             description = (listDescriptionController.text.length > 0) ? listDescriptionController.text : "";
      Navigator.of(ctx).pop(new ListObject(name, description, new List()));
    }
  }
}

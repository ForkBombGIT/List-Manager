import 'package:flutter/material.dart';

import 'package:list_manager/newlist.dart';
import 'package:list_manager/listobject.dart';
import 'package:list_manager/listobjectview.dart';
import 'package:list_manager/custompopup.dart';
import 'package:list_manager/preferencehandling.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ListObject> lists = [];
  List<CustomPopup> tileChoices = [
    CustomPopup(title: "Edit", icon: Icons.edit),
    CustomPopup(title: "Remove", icon: Icons.delete)
  ];

  @override
  void initState() {
    super.initState();
    loadList().then((val) { 
      setState(() {
        lists = val; 
      }); 
    });
  }

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
              padding: (lists.length == 0) ? EdgeInsets.symmetric(vertical: 25.0) : EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: _buildListComponent()
            ),
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _newList(context);
        },
        tooltip: 'Create a List',
        child: Icon(Icons.add),
      ),
    );
  } 

  //builds listview depending on whether there is data or not
  Widget _buildListComponent() {
    if (lists.length == 0) return Text('Create some lists!', textAlign: TextAlign.center, style: TextStyle(fontSize: 24.0));
    return ListView.builder(
      itemCount: lists.length,
      itemBuilder: _buildListItem
    );
  } 

  //builds list item and defines behavior
  Widget _buildListItem(BuildContext ctx, int index){
    return Card (
      child: ListTile ( 
        title: Text(lists[index].name),
        subtitle: Text(lists[index].description),
        onTap: () {
            _handleTileTap(ctx,index);
        },
        trailing: PopupMenuButton<CustomPopup>(
          onSelected: (CustomPopup choice) { _handleMenuTap(choice, index); },
          itemBuilder: (BuildContext ctx) {
            return tileChoices.map((CustomPopup option) => 
            PopupMenuItem(
              value: option, 
              child: ListTile(
                leading:Icon(option.icon), 
                title:Text(option.title)
              )
            )
            ).toList();
          }
        )
      )
    );
  }
  
  //opens window for list creation
  _newList(BuildContext ctx) async {
    ListObject result = await Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => NewList(title: "Create a List")),
    );

    //if there is a result, add it to the list
    if (result != null) {
      setState(() {
        lists.add(result);
      });
    }
    saveList(lists);
  }

  //handles tile tap, opens the list view for editing
  _handleTileTap(BuildContext ctx, int index) async {
    ListObject result = await Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => ListObjectView(listobj: lists[index])),
    );

    lists[index] = result;
    saveList(lists);
  }

  _handleMenuTap(CustomPopup choice, int index) {
      switch (choice.title) {
        case "Edit":
          _menuTapRename(index, lists[index]);
          break;
        case "Remove":
          _menuTapRemove(lists[index]);
          break;
      }

      saveList(lists);
  }

  _menuTapRename(int index, ListObject listObject) {
    ListObject newObject = listObject;
    TextEditingController listNameController = new TextEditingController(text: listObject.name);
    TextEditingController listDescriptionController = new TextEditingController(text: listObject.description);
    final _formKey = GlobalKey<FormState>();
    return showDialog<String>(
    context: context,
    barrierDismissible: true, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit list details'),
        content: new Form (
        key: _formKey,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new TextFormField(
              controller: listNameController,
              validator:  (value) {
                if (value.isEmpty)
                  return 'The list name can\'t be left empty';
                return null;
              },
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'List Name', hintText: 'eg. To-do'),
              )
            ),
            new Expanded(
              child: new TextFormField(
              controller: listDescriptionController,
              decoration: new InputDecoration(
                  labelText: 'List Description', 
                  hintText: 'eg. Stuff to do today'),
              )
            )
          ])
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Submit'),
              onPressed: () {
                newObject.name = listNameController.text;
                newObject.description = listDescriptionController.text;
                setState(() {
                  lists[index] = newObject;
                });
                saveList(lists);
                Navigator.of(context).pop();
              },
            ),
          ],
      );
    },
  );
}

  _menuTapRemove(ListObject listObject) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
        title: Text('Do you want to remove "' + listObject.name + '"?'),
        content: const Text('It cannot be restored if you do'),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () {
                Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: () {
              setState(() {
                lists.remove(listObject); 
              });
              saveList(lists);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
      }
    );
  }
}

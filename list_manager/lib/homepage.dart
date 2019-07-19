import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:list_manager/newlist.dart';
import 'package:list_manager/listobject.dart';
import 'package:list_manager/listobjectview.dart';
import 'package:list_manager/CustomPopupListItem.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ListObject> lists = [];
  List<CustomPopupListItem> tileChoices = [
    CustomPopupListItem(title: "Rename", icon: Icons.edit),
    CustomPopupListItem(title: "Delete", icon: Icons.delete)
  ];

  @override
  void initState() {
    super.initState();
    _loadList().then((val) { 
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
        trailing: PopupMenuButton(
          itemBuilder: (BuildContext ctx) {
            return tileChoices.map((CustomPopupListItem option) => 
            PopupMenuItem(value: option, child: ListTile(
              leading:
              Icon(option.icon), 
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
    _saveList();
  }

  //handles tile tap, opens the list view for editing
  _handleTileTap(BuildContext ctx, int index) async {
    ListObject result = await Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => ListObjectView(listobj: lists[index])),
    );

    lists[index] = result;
    _saveList();
  }
  
  _saveList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("lists", json.encode(lists));
  }

  _loadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonList = json.decode(prefs.getString("lists") ?? "") as List;
    var listItems = jsonList.map((i) => new ListObject.fromJson(i)).toList();
    return listItems;
  }
}

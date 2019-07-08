import 'package:flutter/material.dart';
import 'package:list_manager/newlist.dart';
import 'package:list_manager/listobject.dart';
import 'package:list_manager/listobjectview.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  }

  //handles tile tap, opens the list view for editing
  _handleTileTap(BuildContext ctx, int index) async {
    ListObject result = await Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => ListObjectView(listobj: lists[index])),
    );

    lists[index] = result;
  }
  
  _saveList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
  }
  _loadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

  }
}

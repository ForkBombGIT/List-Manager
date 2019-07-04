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
              padding: (lists.length == 0) ? EdgeInsets.symmetric(vertical: 25.0) : EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: _buildComponent(lists)
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
  
  _newList(BuildContext ctx) async {
    ListObject result = await Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => NewList()),
    );

    if (result != null) lists.add(result);
  }

  Widget _buildComponent(List content) {
    if (content.length == 0) return Text('Create some lists!', textAlign: TextAlign.center, style: TextStyle(fontSize: 24.0));
    return ListView.builder(
      itemCount: lists.length,
      itemBuilder: _buildListItem
    );
  } 

  Widget _buildListItem(BuildContext ctx, int index){
    return Card (
      child: ListTile ( 
        title: Text(lists[index].name),
        onTap: () {_handleTileTap(ctx);}
      )
    );
  }

  Widget _handleTileTap(BuildContext ctx) {

  }
}

import 'package:flutter/material.dart';
import 'package:list_manager/listobject.dart';

class NewList extends StatefulWidget {
  NewList({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _NewListState createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  TextEditingController listNameController = new TextEditingController();
  TextEditingController listDescriptionController = new TextEditingController();
  TextEditingController listItemController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String,bool> map = new Map();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(null),
        ),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.check),
            onPressed: () { _submitNewList(context); }
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
                    return 'The list name can\'t be left empty!';
                  return null;
                },
                controller: listNameController,
                autofocus: true,
                decoration: new InputDecoration(
                  labelText: 'Name',
                  hintText: 'eg. To-do'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                controller: listDescriptionController,
                decoration: new InputDecoration(
                  labelText: 'Description',
                  hintText: 'eg. Stuff to do today'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                controller: listItemController,
                decoration: new InputDecoration(
                  labelText: 'List Item',
                  hintText: 'eg. Eat string beans',
                  suffixIcon: 
                  IconButton(icon: Icon(Icons.arrow_forward_ios),
                   onPressed: () {
                      setState(() {
                        map[listItemController.text] = false;
                      });
                      
                      WidgetsBinding.instance.addPostFrameCallback((_) {listItemController.clear();});
                    },
                  ),
                ),
              ),
            ),
            Expanded (
              child: Padding(
                padding: (map.length == 0) ? EdgeInsets.symmetric(vertical: 25.0) : EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                child:  _buildList()
              )
            )
          ],
        )
      )
    );
  }

  //builds listview widget if there is data
  _buildList() {
    if (map.length == 0) return Text('Add some items!', textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0));
    return ListView.separated(
      itemCount: map.length,
      itemBuilder: _buildListItem,
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  //builds listview tile and defines behavior
  Widget _buildListItem(BuildContext ctx, int index){
    return ListTile ( 
      title: Text(map.keys.toList()[index]),
      leading: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () {
            setState(() {
              map.remove(map.keys.toList()[index]);
            });
          },
      )
    );    
  }

  //submits new list
  _submitNewList(BuildContext ctx) {
    if (_formKey.currentState.validate()) {
      String name = listNameController.text,
             description = (listDescriptionController.text.length > 0) ? listDescriptionController.text : "";
      Navigator.of(ctx).pop(new ListObject(name, description, map));
    }
  }
}
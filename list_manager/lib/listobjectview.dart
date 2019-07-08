import 'package:flutter/material.dart';
import 'package:list_manager/listobject.dart';

class ListObjectView extends StatefulWidget {
  ListObjectView({Key key, this.listobj}) : super(key : key);
  final ListObject listobj;
  @override
  _ListObjectView createState() => _ListObjectView();
}

class _ListObjectView extends State<ListObjectView>{
  TextEditingController listItemController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text(widget.listobj.name),
        leading: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () => _handleClose(context),
        ),
      ), 
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                controller: listItemController,
                decoration: new InputDecoration(
                  labelText: 'List Item',
                  suffixIcon: 
                  IconButton(icon: Icon(Icons.arrow_forward_ios),
                   onPressed: () {
                      setState(() {
                        widget.listobj.addItem(listItemController.text);
                      });
                      listItemController.clear();
                    },
                  ),
                ),
              ),
            ),
          Expanded(
            child: Padding (
              padding: (widget.listobj.getItems().length == 0) ? EdgeInsets.symmetric(vertical: 25.0) : EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: _buildListComponent()
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListComponent() {
    if (widget.listobj.getItems().length == 0) return Text('Add some items!', textAlign: TextAlign.center, style: TextStyle(fontSize: 24.0));
    return ListView.separated(
      itemCount: widget.listobj.getItems().length,
      itemBuilder: _buildListItem,
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildListItem(BuildContext ctx, int index) {
    return ListTile ( 
      title: Text(widget.listobj.getItems()[index]),
      trailing: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () {
            setState(() {
              widget.listobj.removeItem(widget.listobj.getItems()[index]);
            });
          },
      )
    ); 
  }

  _handleClose(BuildContext ctx) {
    Navigator.of(ctx).pop(widget.listobj);
  }
}
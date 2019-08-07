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
  final FocusNode _itemFocus = FocusNode();
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
      body: WillPopScope(
        onWillPop: () {_handleClose(context);},
        child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                focusNode: _itemFocus,
                controller: listItemController,
                onFieldSubmitted: (term) {
                  _newItem();
                  FocusScope.of(context).requestFocus(_itemFocus);
                },
                decoration: new InputDecoration(
                  labelText: 'List Item',
                  suffixIcon: 
                    IconButton(icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                        setState(() {
                          widget.listobj.addItem(listItemController.text);
                        });
                        WidgetsBinding.instance.addPostFrameCallback((_) {listItemController.clear();});
                      },
                  ),
                ),
              ),
            ),
          Expanded(
            child: Padding (
              padding: (widget.listobj.getItems().length == 0) ? EdgeInsets.symmetric(vertical: 25.0) : EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
              child: _buildListComponent()
            ),
          ),
        ],
      )
      ),
    );
  }

  //builds list component, controls aesthetic and behavior
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

  //controls aesthetic of list tile
  Widget _buildListItem(BuildContext ctx, int index) {
    List keys = widget.listobj.getItems().keys.toList();
    return CheckboxListTile ( 
      title: Text(keys[index],style: TextStyle(decoration: (widget.listobj.getItems()[keys[index]]) ? TextDecoration.lineThrough : null)),
      value: widget.listobj.getItems()[keys[index]],
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool value) {
        setState(() {
          widget.listobj.getItems()[keys[index]] = value;
        });
        if (value) Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(keys[index] + " completed!")));
      },
      secondary: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () {
            var item = keys[index];
            setState(() {
              widget.listobj.removeItem(item);
            });
            Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(keys[index] + " removed!"), action: SnackBarAction(label: 'Undo', onPressed: () {
              setState(() {
               widget.listobj.addItem(item); 
              });
            })));
          },
      ),
    ); 
  }

  _newItem(){
    setState(() {
      widget.listobj.addItem(listItemController.text);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {listItemController.clear();});
  }

  //called which view is closed
  _handleClose(BuildContext ctx) {
    Navigator.of(ctx).pop(widget.listobj);
  }
}
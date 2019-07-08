class ListObject {
  String name, description;
  List _contents;

  //constructor
  ListObject(String name, String desc, List contents) : name = name, description = desc, _contents = contents;

  //getters and setters
  List getItems() {return _contents;}
  addItem(String item) {_contents.add(item);}
  removeItem(String item) {_contents.remove(item);}
}
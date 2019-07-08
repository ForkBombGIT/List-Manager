class ListObject {
  String name, description;
  List _contents;

  //constructor
  ListObject(String name, String desc, List contents) : name = name, description = desc, _contents = contents;

  //getters and setters
  List getItems() {return _contents;}
  addItem(String item) {_contents.add(item);}
  removeItem(String item) {_contents.remove(item);}

  //json mapping
  ListObject.fromJson(Map<String,dynamic> json) : name = json["name"], description = json["description"], _contents = json["contents"];
  Map<String,dynamic> toJson() => {'name': name, 'description': description, 'contents': _contents};
}
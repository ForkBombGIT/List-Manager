class ListObject {
  String name, description;
  List _contents;

  //constructor
  ListObject(String name, String desc, List contents) : name = name, description = desc, _contents = contents;
  ListObject.json({String name, String desc, List contents});

  //getters and setters
  List getItems() {return _contents;}
  addItem(String item) {_contents.add(item);}
  removeItem(String item) {_contents.remove(item);}

  //json mapping
  Map<String,dynamic> toJson() => {'name': name, 'description': description, 'contents': _contents};
  factory ListObject.fromJson(Map<String,dynamic> json) {
    return ListObject(json["name"] as String, json['description'] as String, json['contents'] as List);
  }
}
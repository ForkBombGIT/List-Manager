class ListObject {
  String name, description;
  Map<String,bool> _contents;

  //constructor
  ListObject(String name, String desc, Map<String,bool> contents) : name = name, description = desc, _contents = contents;
  ListObject.json({String name, String desc, List contents});

  //getters and setters
  Map<String,bool> getItems() {return _contents;}
  addItem(String item) {_contents[item] = false;}
  removeItem(String item) {_contents.remove(item);}

  //json mapping
  Map<String,dynamic> toJson() => {'name': name, 'description': description, 'contents': _contents};
  factory ListObject.fromJson(Map<String,dynamic> json) {
    return ListObject(json["name"] as String, json['description'] as String, Map<String, bool>.from(json["contents"]));
  }
}
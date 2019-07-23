import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:list_manager/listobject.dart';

saveList(List<ListObject> lists) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("lists", json.encode(lists));
}

loadList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var jsonList = json.decode(prefs.getString("lists") ?? "") as List;
  var listItems = jsonList.map((i) => new ListObject.fromJson(i)).toList();
  return listItems;
}
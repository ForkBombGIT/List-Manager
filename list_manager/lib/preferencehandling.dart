import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:list_manager/listobject.dart';

saveList(List<ListObject> lists) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("lists", json.encode(lists));
}

loadList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var jsonString = prefs.getString("lists") ?? '';
  List<ListObject> jsonList = [];
  if (jsonString.isNotEmpty) jsonList = (json.decode(jsonString) as List).map((i) => new ListObject.fromJson(i)).toList();
  return jsonList;
}
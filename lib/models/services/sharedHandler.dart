/*import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedHandler{
  final String key = "SearchKey";


  Future<bool> removeItemToList(String item) async{
    final instance = await SharedPreferences.getInstance();
    final list = await getList();
    list.remove(item);
    await instance.setStringList(key, list);
    return true;
  }
  Future<bool> addItemToList(String item)async{
    final instance = await SharedPreferences.getInstance();
    final list = await getList();
    list.add(item);
    await instance.setStringList(key, list);
    return true;
  }
  Future <List<String>> getList()async{
      final instance = await SharedPreferences.getInstance();
      final List<String> results = instance.getStringList(key) ?? [];
      return results;
  }
}
*/
import 'package:shared_preferences/shared_preferences.dart';

class SharedHandler {
  final String key = "SearchKey";

  Future<bool> removeItemFromList(String item) async {
    final instance = await SharedPreferences.getInstance();
    final list = await getList();
    if (list.contains(item)) {
      list.remove(item);
      await instance.setStringList(key, list);
    }
    return true;
  }

  Future<bool> addItemToList(String item) async {
    final instance = await SharedPreferences.getInstance();
    final list = await getList();
    if (!list.contains(item)) {
      list.add(item);
      await instance.setStringList(key, list);
    }
    return true;
  }

  Future<List<String>> getList() async {
    final instance = await SharedPreferences.getInstance();
    try {
      final List<String> results = instance.getStringList(key) ?? [];
      return results;
    } catch (e) {
      // If there's an error (e.g., the key stores a string instead of a list), clear the invalid data
      await instance.remove(key);
      return [];
    }
  }
}

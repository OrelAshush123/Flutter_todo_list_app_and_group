import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
import '../models/group.dart';

class Storage {
  static Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    String? tasksJson = prefs.getString('tasks');
    if (tasksJson == null) return [];
    List tasksList = jsonDecode(tasksJson);
    return tasksList.map((task) => Task.fromJson(task)).toList();
  }

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tasks', jsonEncode(tasks));
  }

  static Future<List<Group>> getGroups() async {
    final prefs = await SharedPreferences.getInstance();
    String? groupsJson = prefs.getString('groups');
    if (groupsJson == null) return [];
    List groupsList = jsonDecode(groupsJson);
    return groupsList.map((group) => Group.fromJson(group)).toList();
  }

  static Future<void> saveGroups(List<Group> groups) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('groups', jsonEncode(groups));
  }
}

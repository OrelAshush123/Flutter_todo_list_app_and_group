import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import 'add_group_screen.dart';
import '../utils/storage.dart';
import '../models/task.dart';
import '../models/group.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  List<Group> groups = [];
  String selectedGroup = "All";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    tasks = await Storage.getTasks();
    groups = await Storage.getGroups();
    setState(() {});
  }

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
      Storage.saveTasks(tasks);
    });
  }

  void deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
      Storage.saveTasks(tasks);
    });
  }

  void addGroup(String groupName) {
    setState(() {
      groups.add(Group(name: groupName));
      Storage.saveGroups(groups);
    });
  }

void deleteGroup(Group group) {
  setState(() {
    // Remove the group
    groups.remove(group);
    Storage.saveGroups(groups);

    // Remove all tasks in that group
    tasks.removeWhere((task) => task.group == group.name);
    Storage.saveTasks(tasks);
  });
}


  @override
  Widget build(BuildContext context) {
    List<Task> filteredTasks = selectedGroup == "All"
        ? tasks
        : tasks.where((task) => task.group == selectedGroup).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Groups", style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: const Text("All"),
              onTap: () {
                setState(() => selectedGroup = "All");
                Navigator.pop(context);
              },
            ),
            ...groups.map((group) {
              return ListTile(
                title: Text(group.name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteGroup(group),
                ),
                onTap: () {
                  setState(() => selectedGroup = group.name);
                  Navigator.pop(context);
                },
              );
            }),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Add Group"),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddGroupScreen(
                      onGroupAdded: (groupName) {
                        addGroup(groupName);
                      },
                    ),
                  ),
                );
                // ignore: use_build_context_synchronously
                if (mounted) {Navigator.pop(context);}
              },
            ),
          ],
        ),
      ),

      body: ListView.builder(
        itemCount: filteredTasks.length,
        itemBuilder: (context, index) {
          Task task = filteredTasks[index];
          return ListTile(
            leading: Checkbox(
              value: task.isComplete,
              onChanged: (value) {
                setState(() {
                  task.isComplete = value!;
                  Storage.saveTasks(tasks);
                });
              },
            ),
            title: Text(task.title),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => deleteTask(task),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (groups.isEmpty) {
            // Show a dialog prompting the user to create a group
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("No Groups Available"),
                content: const Text("Please create a group first."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          } else {
            // Navigate to the Add Task Screen if groups exist
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(
                  onTaskAdded: (title, group) {
                    addTask(Task(title: title, group: group));
                  },
                  groups: groups.map((group) => group.name).toList(),
                ),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

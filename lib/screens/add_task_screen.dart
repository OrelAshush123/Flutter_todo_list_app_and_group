import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(String title, String group) onTaskAdded;
  final List<String> groups;

  const AddTaskScreen({super.key, required this.onTaskAdded, required this.groups});

  @override
  AddTaskScreenState createState() => AddTaskScreenState();
}

class AddTaskScreenState extends State<AddTaskScreen> {
  String taskTitle = '';
  String selectedGroup = '';

  @override
  void initState() {
    super.initState();
    selectedGroup = widget.groups.isNotEmpty ? widget.groups.first : 'None';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => setState(() => taskTitle = value),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedGroup,
              items: widget.groups
                  .map((group) => DropdownMenuItem(
                        value: group,
                        child: Text(group),
                      ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Select Group',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => setState(() => selectedGroup = value ?? ''),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                if (taskTitle.isNotEmpty) {
                  widget.onTaskAdded(taskTitle, selectedGroup);
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.save),
              label: const Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}

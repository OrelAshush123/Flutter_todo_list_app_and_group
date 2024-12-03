import 'package:flutter/material.dart';

class AddGroupScreen extends StatefulWidget {
  final Function(String groupName) onGroupAdded;

  const AddGroupScreen({super.key, required this.onGroupAdded});

  @override
  AddGroupScreenState createState() => AddGroupScreenState();
}

class AddGroupScreenState extends State<AddGroupScreen> {
  String groupName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Group"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Group Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => setState(() => groupName = value),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                if (groupName.isNotEmpty) {
                  widget.onGroupAdded(groupName);
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.save),
              label: const Text("Add Group"),
            ),
          ],
        ),
      ),
    );
  }
}

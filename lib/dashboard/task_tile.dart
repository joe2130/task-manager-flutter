import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final Map<String, dynamic> task;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[900], // Optional: dark background for contrast
      child: ListTile(
        title: Text(
          task['title'],
          style: const TextStyle(color: Colors.white), // White text
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Color(0xFFD4AF37)), // Gold icon
          onPressed: onDelete,
        ),
      ),
    );
  }
}

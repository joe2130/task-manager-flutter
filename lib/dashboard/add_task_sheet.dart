import 'package:flutter/material.dart';

class AddTaskSheet extends StatefulWidget {
  final Function(String) onAdd;
  const AddTaskSheet({super.key, required this.onAdd});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Handles keyboard
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Critical for bottom sheets
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Task title',
              labelStyle: const TextStyle(color: Color(0xFFD4AF37)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox( // Constrained button width
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  widget.onAdd(_controller.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add Task'),
            ),
          ),
          const SizedBox(height: 8), // Extra bottom padding
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
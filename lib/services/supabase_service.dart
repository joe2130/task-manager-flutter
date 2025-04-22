import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Get all tasks for current user
  Future<List<Map<String, dynamic>>> getTasks() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final response = await _supabase
          .from('task')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }

  // Add a new task
  Future<void> addTask(String title) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await _supabase.from('task').insert({
        'user_id': userId,
        'title': title,
        'is_completed': false,
      });
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  // Update task completion status
  Future<void> toggleTaskCompletion(String taskId, bool isCompleted) async {
    try {
      await _supabase
          .from('task')
          .update({'is_completed': isCompleted}).eq('id', taskId);
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      await _supabase.from('task').delete().eq('id', taskId);
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  // Stream tasks for real-time updates
  Stream<List<Map<String, dynamic>>> getTasksStream() {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    return _supabase
        .from('task')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('created_at')
        .map((event) => List<Map<String, dynamic>>.from(event));
  }
}
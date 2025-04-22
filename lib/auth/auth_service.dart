import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  bool _isLoggedIn = false;
  
  bool get isLoggedIn => _isLoggedIn;

  AuthService() {
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final session = _supabase.auth.currentSession;
    _isLoggedIn = session != null;
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }

Future<void> login(String email, String password) async {
  try {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.session == null) {
      throw Exception('Email not verified. Please check your inbox.');
    }
    _isLoggedIn = true;
    notifyListeners();
  } on AuthException catch (e) {
    throw Exception(e.message); // More specific error
  } catch (e) {
    throw Exception('Login failed: $e');
  }
}

  Future<void> logout() async {
    await _supabase.auth.signOut();
    _isLoggedIn = false;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Check your email for verification link'),
            ElevatedButton(
              onPressed: () => _resendVerification(),
              child: const Text('Resend Email'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _resendVerification() async {
    try {
      await Supabase.instance.client.auth.resend(
        type: OtpType.signup,
        email: 'user@example.com', // Get from auth state
      );
    } catch (e) {
      // Handle error
    }
  }
}
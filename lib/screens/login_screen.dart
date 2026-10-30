
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../services/auth_service.dart';
import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();

  String? errorMessage;
  bool isLoading = false;

  Future<void> handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Email dan password wajib diisi.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await authService.login(email, password);

      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.dashboard,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      setState(() {
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'Format email tidak valid.';
          case 'user-not-found':
          case 'wrong-password':
          case 'invalid-credential':
            errorMessage = 'Email atau password salah.';
          case 'user-disabled':
            errorMessage = 'Akun ini dinonaktifkan.';
          case 'too-many-requests':
            errorMessage = 'Terlalu banyak percobaan. Coba lagi nanti.';
          case 'network-request-failed':
            errorMessage = 'Periksa koneksi internet kamu.';
          default:
            errorMessage = 'Login gagal. Silakan coba lagi.';
        }
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        errorMessage = 'Terjadi kesalahan. Silakan coba lagi.';
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ROBSPACE'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            AppTextField(
              label: 'Email',
              controller: emailController,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Password',
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 16),
            if (isLoading)
              const CircularProgressIndicator()
            else
              PrimaryButton(
                text: 'Login',
                onPressed: handleLogin,
              ),
          ],
        ),
      ),
    );
  }
}

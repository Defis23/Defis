
import 'package:flutter/material.dart';

import '../features/profile/data/profile_repository.dart';
import '../features/profile/presentation/widgets/profile_form.dart';
import '../models/user_model.dart';
import '../routes/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileRepository = ProfileRepository();

  bool isLoading = false;
  String? errorMessage;

  Future<void> handleLogout() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await profileRepository.logout();

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    } catch (_) {
      if (!mounted) return;

      setState(() {
        errorMessage = 'Logout gagal. Silakan coba lagi.';
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
  Widget build(BuildContext context) {
    const user = UserModel(
      name: 'Defis',
      email: 'admin@robspace.com',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: ProfileForm(
          user: user,
          isLoading: isLoading,
          errorMessage: errorMessage,
          onLogout: handleLogout,
        ),
      ),
    );
  }
}

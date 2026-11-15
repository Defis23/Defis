
import 'package:flutter/material.dart';

import '../../../../models/user_model.dart';

class ProfileForm extends StatelessWidget {
  final UserModel user;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onLogout;

  const ProfileForm({
    super.key,
    required this.user,
    required this.isLoading,
    required this.errorMessage,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isWide = screenWidth >= 600;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isWide ? 32 : 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Semantics(
                  label: 'Foto profil pengguna',
                  child: const CircleAvatar(
                    radius: 45,
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                user.email,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (errorMessage != null) ...[
                Semantics(
                  liveRegion: true,
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: isLoading ? null : onLogout,
                  child: isLoading
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text('Sedang logout...'),
                          ],
                        )
                      : const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

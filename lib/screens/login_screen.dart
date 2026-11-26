
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/app_logger.dart';
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
    if (isLoading) return;

    FocusScope.of(context).unfocus();

    final email = emailController.text.trim();
    final password = passwordController.text;

    AppLogger.info('Login process started.');

    if (email.isEmpty || password.isEmpty) {
      AppLogger.warning('Login validation failed: empty input.');

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

      AppLogger.info('Login successful.');

      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.dashboard,
      );
    } on FirebaseAuthException catch (e) {
      AppLogger.error(
        'Firebase login failed. Code: ${e.code}',
        error: e,
      );

      if (!mounted) return;

      setState(() {
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'Format email tidak valid.';
            break;
          case 'user-not-found':
          case 'wrong-password':
          case 'invalid-credential':
            errorMessage = 'Email atau password salah.';
            break;
          case 'user-disabled':
            errorMessage = 'Akun ini dinonaktifkan.';
            break;
          case 'too-many-requests':
            errorMessage =
                'Terlalu banyak percobaan. Coba lagi nanti.';
            break;
          case 'network-request-failed':
            errorMessage = 'Periksa koneksi internet kamu.';
            break;
          default:
            errorMessage = 'Login gagal. Silakan coba lagi.';
        }
      });
    } catch (e, stackTrace) {
      AppLogger.error(
        'Unexpected login error.',
        error: e,
        stackTrace: stackTrace,
      );

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

  Future<void> handleGoogleLogin() async {
    if (isLoading) return;

    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await authService.signInWithGoogle();

      AppLogger.info('Google login successful.');

      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.dashboard,
      );
    } on FirebaseAuthException catch (e) {
      AppLogger.error(
        'Google login failed. Code: ${e.code}',
        error: e,
      );

      if (!mounted) return;

      setState(() {
        errorMessage = 'Login Google gagal. Silakan coba lagi.';
      });
    } catch (e, stackTrace) {
      AppLogger.error(
        'Unexpected Google login error.',
        error: e,
        stackTrace: stackTrace,
      );

      if (!mounted) return;

      setState(() {
        errorMessage = 'Login Google gagal. Silakan coba lagi.';
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
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isWide = screenWidth >= 700;

    const purple = Color(0xFF6D45D9);
    const darkPurple = Color(0xFF392064);
    const background = Color(0xFFF7F4FC);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFF9F6FF),
                        Color(0xFFF1EBFF),
                        Color(0xFFF8F5FC),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWide ? 40 : 24,
                      vertical: 32,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 460,
                        ),
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20),

                            // Logo ROBSPACE
                            Center(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.circular(28),
                                  boxShadow: [
                                    BoxShadow(
                                      color: purple.withValues(
                                        alpha: 0.20,
                                      ),
                                      blurRadius: 28,
                                      offset: const Offset(0, 12),
                                    ),
                                  ],
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset(
                                  'images/robspace_logo.jpg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            const Text(
                              'ROBSPACE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                                color: darkPurple,
                              ),
                            ),

                            const SizedBox(height: 10),

                            const Text(
                              'Your next unforgettable experience.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF81758F),
                              ),
                            ),

                            const SizedBox(height: 36),

                            // Login Card
                            Container(
                              padding: EdgeInsets.all(
                                isWide ? 32 : 24,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(28),
                                border: Border.all(
                                  color: const Color(0xFFEAE3F7),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF392064)
                                        .withValues(alpha: 0.07),
                                    blurRadius: 30,
                                    offset: const Offset(0, 12),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Welcome back!',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF241638),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  const Text(
                                    'Masuk ke akun ROBSPACE kamu.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF8A8097),
                                    ),
                                  ),

                                  const SizedBox(height: 28),

                                  // Email
                                  const Text(
                                    'Email',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF34264A),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  AppTextField(
                                    label: 'Email',
                                    controller: emailController,
                                  ),

                                  const SizedBox(height: 20),

                                  // Password
                                  const Text(
                                    'Password',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF34264A),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  AppTextField(
                                    label: 'Password',
                                    controller: passwordController,
                                    obscureText: true,
                                  ),

                                  const SizedBox(height: 20),

                                  // Error Message
                                  if (errorMessage != null) ...[
                                    Container(
                                      padding:
                                          const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFFFFEEEE,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(14),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              errorMessage!,
                                              style:
                                                  const TextStyle(
                                                color: Color(
                                                  0xFFB3261E,
                                                ),
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],

                                  // Email Login Button
                                  SizedBox(
                                    height: 54,
                                    child: isLoading
                                        ? const Center(
                                            child:
                                                CircularProgressIndicator(
                                              color: purple,
                                            ),
                                          )
                                        : PrimaryButton(
                                            text: 'Login',
                                            onPressed: handleLogin,
                                          ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Divider
                                  const Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: Color(0xFFE5DDF1),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 14,
                                        ),
                                        child: Text(
                                          'OR',
                                          style: TextStyle(
                                            color: Color(
                                              0xFF8A8097,
                                            ),
                                            fontWeight:
                                                FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Color(0xFFE5DDF1),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 20),

                                  // Google Login Button
                                  SizedBox(
                                    height: 54,
                                    child: OutlinedButton(
                                      onPressed: isLoading
                                          ? null
                                          : handleGoogleLogin,
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor:
                                            Colors.white,
                                        foregroundColor:
                                            const Color(0xFF34264A),
                                        side: const BorderSide(
                                          color: Color(
                                            0xFFE2D8F0,
                                          ),
                                        ),
                                        shape:
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            'https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg',
                                            width: 22,
                                            height: 22,
                                            errorBuilder:
                                                (context, error,
                                                    stackTrace) {
                                              return const Icon(
                                                Icons.login,
                                                size: 22,
                                              );
                                            },
                                          ),
                                          const SizedBox(width: 12),
                                          const Text(
                                            'Sign in with Google',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight:
                                                  FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 28),

                            // Footer
                            const Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.bolt,
                                  size: 16,
                                  color: purple,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Discover. Connect. Experience.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF8A8097),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

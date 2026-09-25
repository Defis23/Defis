import 'package:flutter/material.dart';
import '../features/events/presentation/screens/event_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/login_screen.dart';
import '../screens/profile_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String events = '/events';

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => const LoginScreen(),
      dashboard: (context) => const DashboardScreen(),
      profile: (context) => const ProfileScreen(),
      events: (context) => const EventScreen(),
    };
  }
}
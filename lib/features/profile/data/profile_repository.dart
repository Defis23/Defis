
import '../../../services/auth_service.dart';

class ProfileRepository {
  final AuthService authService;

  ProfileRepository({AuthService? authService})
      : authService = authService ?? AuthService();

  Future<void> logout() async {
    await authService.logout();
  }
}

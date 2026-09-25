class AuthService {
  bool login(String email, String password) {
    return email == 'admin@robspace.com' && password == '123456';
  }
}
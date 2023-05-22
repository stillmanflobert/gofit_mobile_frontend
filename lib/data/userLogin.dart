class UserManager {
  static final UserManager _instance = UserManager._internal();

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();

  User? _currentUser;

  User? get currentUser => _currentUser;

  void login(User user) {
    _currentUser = user;
  }

  void logout() {
    _currentUser = null;
  }
}

class User {
  final String id_user;
  final String password;
  final String role;

  User({required this.id_user, required this.password, required this.role});
}

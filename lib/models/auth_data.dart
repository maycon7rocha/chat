enum AuthMode {
  LOGIN,
  SIGNAP,
}

class AuthData {
  String name;
  String email;
  String password;
  AuthMode _mode = AuthMode.LOGIN;

  bool get isSigup {
    return _mode == AuthMode.SIGNAP;
  }

  bool get isLogin {
    return _mode == AuthMode.LOGIN;
  }

  void toggleMode() {
    _mode = _mode == AuthMode.LOGIN ? AuthMode.SIGNAP : AuthMode.LOGIN;
  }
}
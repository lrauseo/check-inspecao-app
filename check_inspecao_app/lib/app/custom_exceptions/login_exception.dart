class LoginException implements Exception {
  String message;
  LoginException(this.message) {
    print('LoginException $message');
  }
}

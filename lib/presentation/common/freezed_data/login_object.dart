class LoginObject {
  String username;
  String password;
  LoginObject(this.username, this.password);
  copyWith({String? username, String? password}) {
    if (username != null) {
      this.username = username;
    }
    if (password != null) {
      this.password = password;
    }
  }
}

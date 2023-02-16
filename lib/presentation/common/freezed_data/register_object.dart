class RegisterObject {
  String username;
  String password;
  String name;

  RegisterObject(this.name, this.username, this.password);
  copyWith({String? name, String? username, String? password}) {
    if (username != null) {
      this.username = username;
    }
    if (password != null) {
      this.password = password;
    }
    if (name != null) {
      this.name = name;
    }
  }
}

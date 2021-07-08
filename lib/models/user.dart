class User {
  int id;
  String email;
  String password;
  String username;

  User({
    this.id,
    this.email,
    this.password,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      username: json['username'],
    );
  }
}

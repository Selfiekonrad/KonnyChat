class User {
  int id;
  String name;
  String password;

  User({required this.id, required this.name, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'name': String name, 'password': String password} => User(id: id, name: name, password: password),
      (_) => throw const FormatException('Failed to load user.')
    };
  }
}

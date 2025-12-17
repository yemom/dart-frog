class User {
  const User({this.id, this.name, this.lastname, this.username, this.password});

  factory User.fromJson(Map json) => User(
    id: json['id'],
    name: json['name'],
    lastname: json['lastname'],
    username: json['username'],
    password: json['password'],
  );

  final int? id;

  final String? name;

  final String? lastname;

  final String? username;

  final String? password;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'lastname': lastname,
    'username': username,
    'password': password,
  };
}

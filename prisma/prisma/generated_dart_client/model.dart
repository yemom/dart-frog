class User {
  const User({this.id, this.name, this.lastname});

  factory User.fromJson(Map json) =>
      User(id: json['id'], name: json['name'], lastname: json['lastname']);

  final int? id;

  final String? name;

  final String? lastname;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'lastname': lastname,
  };
}

class User {
  final String? imagePath;
  late String name;
  late String email;

  User({
    this.imagePath,
    required this.name,
    required this.email,
  });

  User copy({
    String? imagePath,
    String? name,
    String? email,
  }) =>
      User(
        imagePath: imagePath ?? this.imagePath,
        name: name ?? this.name,
        email: email ?? this.email,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        imagePath: json['imagePath'],
        name: json['name'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'name': name,
        'email': email,
      };
}

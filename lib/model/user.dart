class User {
  final String? imagePath;
  late String name;
  late String email;
  late int? userId;

  User({
    this.imagePath,
    this.userId,
    required this.name,
    required this.email,
  });

  User copy({
    String? imagePath,
    String? name,
    String? email,
    int? userId,
  }) =>
      User(
        imagePath: imagePath ?? this.imagePath,
        name: name ?? this.name,
        email: email ?? this.email,
        userId: userId ?? this.userId,
      );

  static User fromJson(Map<String, dynamic> json) => User(
      imagePath: json['imagePath'],
      name: json['name'],
      email: json['email'],
      userId: json['userId']);

  Map<String, dynamic> toJson() =>
      {'imagePath': imagePath, 'name': name, 'email': email, 'userId': userId};
}

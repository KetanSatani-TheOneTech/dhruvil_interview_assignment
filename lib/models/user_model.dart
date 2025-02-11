class User {
  final String email;
  final String name;

  User({required this.email, required this.name});

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
    };
  }
}

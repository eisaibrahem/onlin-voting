class User {
  final String name;
  final String jwt;
  final String email;
  String phone="";
  String image="";

  User({required this.name, required this.email, required this.jwt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json["email"],
        jwt: json["jwt"],
        name: json["name"],
    );
  }
}

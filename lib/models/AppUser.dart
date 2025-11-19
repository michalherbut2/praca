// Prosty model do przechowywania danych użytkownika
class AppUser {
  final String id;
  final String name;
  final String email;
  final String? pictureUrl;
  final int points;
  final String role;


  AppUser(
      {required this.id,
      required this.name,
      required this.email,
      this.pictureUrl,
      this.points = 0,
        this.role = 'mostowiak',});

  // factory AppUser.fromMap(Map<String, dynamic> map) {
  //   String? url;
  //   if (map['picture'] != null &&
  //       map['picture']['data'] != null &&
  //       map['picture']['data']['url'] != null) {
  //     url = map['picture']['data']['url'];
  //   }
  //
  //   return AppUser(
  //     id: map['id'] ?? '',
  //     name: map['name'] ?? '',
  //     email: map['email'] ?? '',
  //     pictureUrl: url,
  //   );
  // }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['userId'] ?? '',
      name: '${map['firstName'] ?? ''} ${map['lastName'] ?? ''}',
      email: map['email'] ?? '',
      points: map['points'] ?? 0,
      role: map['role'] ?? 'mostowiak',
      pictureUrl: null, // jeśli nie masz zdjęcia w JSON
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'pictureUrl': pictureUrl,
    'points': points,
    'role': role,
  };

  static AppUser fromJson(Map<String, dynamic> json) => AppUser(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    pictureUrl: json['pictureUrl'],
    points: json['points'] ?? 0,
    role: json['role'] ?? 'mostowiak',
  );
}

import 'package:radon_app/models/user_logger.dart';

class User {
  int id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String password;
  List<UserLogger> userLoggers;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.userLoggers,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      userLoggers: json['userLoggers'].map<UserLogger>((userLogger) => UserLogger.fromJson(userLogger)).toList(),
    );
  }
}

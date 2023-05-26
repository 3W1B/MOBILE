class UserLogger {
  int id;
  int userId;
  String loggerId;

  UserLogger({
    required this.id,
    required this.userId,
    required this.loggerId,
  });

  factory UserLogger.fromJson(Map<String, dynamic> json) {
    return UserLogger(
      id: json['id'],
      userId: json['userId'],
      loggerId: json['loggerId'],
    );
  }
}

class LogOutside {
  int id;
  int logId;
  num temperature;
  num humidity;

  LogOutside({
    required this.id,
    required this.logId,
    required this.temperature,
    required this.humidity,
  });

  factory LogOutside.fromJson(Map<String, dynamic> json) {
    return LogOutside(
      id: json['id'],
      logId: json['logId'],
      temperature: json['temperature'],
      humidity: json['humidity'],
    );
  }
}

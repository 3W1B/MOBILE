class LogInside {
  int id;
  int logId;
  num temperature;
  num humidity;
  num radonLta;
  num radonSta;

  LogInside({
    required this.id,
    required this.logId,
    required this.temperature,
    required this.humidity,
    required this.radonLta,
    required this.radonSta,
  });

  factory LogInside.fromJson(Map<String, dynamic> json) {
    return LogInside(
      id: json['id'],
      logId: json['logId'],
      temperature: json['temperature'],
      humidity: json['humidity'],
      radonLta: json['radonLta'],
      radonSta: json['radonSta'],
    );
  }
}

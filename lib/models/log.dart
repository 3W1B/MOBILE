import 'log_inside.dart';
import 'log_outside.dart';

class Log {
  int id;
  String loggerId;
  DateTime timestamp;
  List<LogInside> logInsides;
  List<LogOutside> logOutsides;

  Log({
    required this.id,
    required this.loggerId,
    required this.timestamp,
    required this.logInsides,
    required this.logOutsides,
  });

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      id: json['id'],
      loggerId: json['loggerId'],
      timestamp: DateTime.parse(json['timestamp']),
      logInsides: json['logInsides'].map<LogInside>((logInside) => LogInside.fromJson(logInside)).toList(),
      logOutsides: json['logOutsides'].map<LogOutside>((logOutside) => LogOutside.fromJson(logOutside)).toList(),
    );
  }
}

import 'location.dart';
import 'log.dart';

class Logger {
  String id;
  String password;
  List<Location> locations;
  List<Log> logs;

  Logger({
    required this.id,
    required this.password,
    required this.locations,
    required this.logs,
  });

  factory Logger.fromJson(Map<String, dynamic> json) {
    return Logger(
      id: json['id'],
      password: json['password'],
      locations: json['locations'].map<Location>((location) => Location.fromJson(location)).toList(),
      logs: json['logs'].map<Log>((log) => Log.fromJson(log)).toList(),
    );
  }
}

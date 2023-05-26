class Location {
  int id;
  String loggerId;
  num latitude;
  num longitude;

  Location({
    required this.id,
    required this.loggerId,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      loggerId: json['loggerId'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

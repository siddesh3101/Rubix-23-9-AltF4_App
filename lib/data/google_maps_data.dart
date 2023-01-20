class UserMaps {
  final double lat;
  final double long;
  final String pending;
  final String userId;
  final String status;

  const UserMaps(
      {required this.lat,
      required this.long,
      required this.pending,
      required this.userId,
      required this.status});

  factory UserMaps.fromMap(Map<dynamic, dynamic> map) {
    return UserMaps(
        lat: map['lat'] ?? '',
        long: map['long'] ?? '',
        pending: map['pending'] ?? '',
        userId: map['userId'] ?? '',
        status: map['status'] ?? '');
  }
}

class RefreshToken {
  final String _token;
  final String _userId;
  final DateTime _expiresAt;

  RefreshToken({
    required String token,
    required String userId,
    required DateTime expiresAt,
  })  : _token = token,
        _userId = userId,
        _expiresAt = expiresAt;

  String get token => _token;
  String get userId => _userId;
  DateTime get expiresAt => _expiresAt;

  factory RefreshToken.fromJson(Map<String, dynamic> json) {
    return RefreshToken(
      token: json['token'],
      userId: json['user'],
      expiresAt: DateTime.parse(json['expiresAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': _token,
      'user': _userId,
      'expiresAt': _expiresAt.toIso8601String(),
    };
  }
}

class Log {
  final String _id;
  final String? _userId;
  final LogType _type;
  final DateTime _timestamp;
  final String _message;
  final Map<String, dynamic> _details;
  final String? _ip;
  final String? _userAgent;
  final LogModule _module;

  // Adding getters
  String get id => _id;
  String? get userId => _userId;
  LogType get type => _type;
  DateTime get timestamp => _timestamp;
  String get message => _message;
  Map<String, dynamic> get details => _details;
  String? get ip => _ip;
  String? get userAgent => _userAgent;
  LogModule get module => _module;

  Log({
    required String id,
    String? userId,
    required LogType type,
    required DateTime timestamp,
    required String message,
    required Map<String, dynamic> details,
    String? ip,
    String? userAgent,
    required LogModule module,
  })  : _id = id,
        _userId = userId,
        _type = type,
        _timestamp = timestamp,
        _message = message,
        _details = details,
        _ip = ip,
        _userAgent = userAgent,
        _module = module;

  factory Log.fromJson(Map<String, dynamic> json) => Log(
        id: json['_id'],
        userId: json['user'],
        type: LogType.values
            .firstWhere((e) => e.toString() == 'LogType.${json['type']}'),
        timestamp: DateTime.parse(json['timestamp']),
        message: json['message'],
        details: Map<String, dynamic>.from(json['details']),
        ip: json['ip'],
        userAgent: json['userAgent'],
        module: LogModule.values
            .firstWhere((e) => e.toString() == 'LogModule.${json['module']}'),
      );

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'user': _userId,
        'type': _type.toString().split('.').last,
        'timestamp': _timestamp.toIso8601String(),
        'message': _message,
        'details': _details,
        'ip': _ip,
        'userAgent': _userAgent,
        'module': _module.toString().split('.').last,
      };
}

enum LogType { error, activity, transaction, system, backup, authentication }

enum LogModule {
  user,
  product,
  client,
  transaction,
  order,
  profit,
  backup,
  other
}

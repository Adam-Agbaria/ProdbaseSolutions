class Backup {
  final String _id;
  final String _userId;
  final DateTime _backupDate;
  final BackupType _backupType;
  final String _description;
  final String _location;
  final BackupStatus _status;
  final int _dataSize;

  // Adding getters
  String get id => _id;
  String get userId => _userId;
  DateTime get backupDate => _backupDate;
  BackupType get backupType => _backupType;
  String get description => _description;
  String get location => _location;
  BackupStatus get status => _status;
  int get dataSize => _dataSize;

  Backup({
    required String id,
    required String userId,
    required DateTime backupDate,
    required BackupType backupType,
    required String description,
    required String location,
    required BackupStatus status,
    required int dataSize,
  })  : _id = id,
        _userId = userId,
        _backupDate = backupDate,
        _backupType = backupType,
        _description = description,
        _location = location,
        _status = status,
        _dataSize = dataSize;

  factory Backup.fromJson(Map<String, dynamic> json) => Backup(
        id: json['_id'],
        userId: json['user'],
        backupDate: DateTime.parse(json['backupDate']),
        backupType: BackupTypeExtension.parse(json['backupType']),
        description: json['description'],
        location: json['location'],
        status: BackupStatusExtension.parse(json['status']),
        dataSize: json['dataSize'],
      );

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'user': _userId,
        'backupDate': _backupDate.toIso8601String(),
        'backupType': _backupType.value,
        'description': _description,
        'location': _location,
        'status': _status.value,
        'dataSize': _dataSize,
      };
}

enum BackupType {
  full,
  incremental,
  differential,
  user_data,
  products,
  clients,
  transactions,
  orders,
  profits,
}

extension BackupTypeExtension on BackupType {
  static BackupType parse(String value) {
    return BackupType.values.firstWhere((e) => e.value == value);
  }

  String get value => this.toString().split('.').last;
}

enum BackupStatus {
  completed,
  in_progress,
  failed,
}

extension BackupStatusExtension on BackupStatus {
  static BackupStatus parse(String value) {
    return BackupStatus.values.firstWhere((e) => e.value == value);
  }

  String get value => this.toString().split('.').last;
}

class Settings {
  final String _id;
  final String _userId;
  final ThemeMode _theme;
  final String _appName;
  final bool _maintenanceMode;
  final double _subscriptionCost;
  final String _currency;
  final double _taxRate;
  final String _supportEmail;
  final NotificationSettings _notificationSettings;
  final BackupSettings _backupSettings;

  Settings({
    required String id,
    required String userId,
    required ThemeMode theme,
    required String appName,
    required bool maintenanceMode,
    required double subscriptionCost,
    required String currency,
    required double taxRate,
    required String supportEmail,
    required NotificationSettings notificationSettings,
    required BackupSettings backupSettings,
  })  : _id = id,
        _userId = userId,
        _theme = theme,
        _appName = appName,
        _maintenanceMode = maintenanceMode,
        _subscriptionCost = subscriptionCost,
        _currency = currency,
        _taxRate = taxRate,
        _supportEmail = supportEmail,
        _notificationSettings = notificationSettings,
        _backupSettings = backupSettings;

  // Getter methods for the private fields
  String get id => _id;
  String get userId => _userId;
  ThemeMode get theme => _theme;
  String get appName => _appName;
  bool get maintenanceMode => _maintenanceMode;
  double get subscriptionCost => _subscriptionCost;
  String get currency => _currency;
  double get taxRate => _taxRate;
  String get supportEmail => _supportEmail;
  NotificationSettings get notificationSettings => _notificationSettings;
  BackupSettings get backupSettings => _backupSettings;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        id: json['_id'],
        userId: json['user'],
        theme: ThemeModeExtension.parse(json['theme']),
        appName: json['appName'],
        maintenanceMode: json['maintenanceMode'],
        subscriptionCost: json['subscriptionCost'].toDouble(),
        currency: json['currency'],
        taxRate: json['taxRate'].toDouble(),
        supportEmail: json['supportEmail'],
        notificationSettings:
            NotificationSettings.fromJson(json['notificationSettings']),
        backupSettings: BackupSettings.fromJson(json['backupSettings']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': userId,
        'theme': theme.value,
        'appName': appName,
        'maintenanceMode': maintenanceMode,
        'subscriptionCost': subscriptionCost,
        'currency': currency,
        'taxRate': taxRate,
        'supportEmail': supportEmail,
        'notificationSettings': notificationSettings.toJson(),
        'backupSettings': backupSettings.toJson(),
      };
}

enum ThemeMode {
  light,
  dark,
}

extension ThemeModeExtension on ThemeMode {
  static ThemeMode parse(String value) {
    return ThemeMode.values.firstWhere((e) => e.value == value);
  }

  String get value => this.toString().split('.').last;
}

class NotificationSettings {
  final bool dailyReport;
  final bool errorNotifications;

  NotificationSettings(
      {required this.dailyReport, required this.errorNotifications});

  factory NotificationSettings.fromJson(Map<String, dynamic> json) =>
      NotificationSettings(
        dailyReport: json['dailyReport'],
        errorNotifications: json['errorNotifications'],
      );

  Map<String, dynamic> toJson() => {
        'dailyReport': dailyReport,
        'errorNotifications': errorNotifications,
      };
}

class BackupSettings {
  final bool autoBackup;
  final BackupFrequency backupFrequency;

  BackupSettings({required this.autoBackup, required this.backupFrequency});

  factory BackupSettings.fromJson(Map<String, dynamic> json) => BackupSettings(
        autoBackup: json['autoBackup'],
        backupFrequency:
            BackupFrequencyExtension.parse(json['backupFrequency']),
      );

  Map<String, dynamic> toJson() => {
        'autoBackup': autoBackup,
        'backupFrequency': backupFrequency.value,
      };
}

enum BackupFrequency {
  daily,
  weekly,
  monthly,
}

extension BackupFrequencyExtension on BackupFrequency {
  static BackupFrequency parse(String value) {
    return BackupFrequency.values.firstWhere((e) => e.value == value);
  }

  String get value => this.toString().split('.').last;
}

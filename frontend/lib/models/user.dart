class User {
  String _id;
  String _username;
  String _email;
  String? _password;
  String _companyName;
  bool _subscriptionStatus;
  DateTime? _subscriptionEndDate;
  Settings _settings;
  DateTime _dateJoined;
  DateTime? _lastLogin;

  User({
    required String id,
    required String username,
    required String email,
    String? password,
    required String companyName,
    required bool subscriptionStatus,
    DateTime? subscriptionEndDate,
    required Settings settings,
    required DateTime dateJoined,
    DateTime? lastLogin,
  })  : _id = id,
        _username = username,
        _email = email,
        _password = password,
        _companyName = companyName,
        _subscriptionStatus = subscriptionStatus,
        _subscriptionEndDate = subscriptionEndDate,
        _settings = settings,
        _dateJoined = dateJoined,
        _lastLogin = lastLogin;

  // Getters
  String get id => _id;
  String get username => _username;
  String get email => _email;
  String? get password => _password;
  String get companyName => _companyName;
  bool get subscriptionStatus => _subscriptionStatus;
  DateTime? get subscriptionEndDate => _subscriptionEndDate;
  Settings get settings => _settings;
  DateTime get dateJoined => _dateJoined;
  DateTime? get lastLogin => _lastLogin;

  // Setters
  set password(String? value) {
    _password = value;
  }

  set lastLogin(DateTime? value) {
    _lastLogin = value;
  }

  // JSON Serialization
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      companyName: json['companyName'],
      subscriptionStatus: json['subscriptionStatus'],
      subscriptionEndDate: json['subscriptionEndDate'] != null
          ? DateTime.parse(json['subscriptionEndDate'])
          : null,
      settings: Settings.fromJson(json['settings']),
      dateJoined: DateTime.parse(json['dateJoined']),
      lastLogin:
          json['lastLogin'] != null ? DateTime.parse(json['lastLogin']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': _id,
      'username': _username,
      'email': _email,
      'password': _password,
      'companyName': _companyName,
      'subscriptionStatus': _subscriptionStatus,
      'subscriptionEndDate': _subscriptionEndDate?.toIso8601String(),
      'settings': _settings.toJson(),
      'dateJoined': _dateJoined.toIso8601String(),
      'lastLogin': _lastLogin?.toIso8601String(),
    };
  }
}

// ... Other classes (Settings, NotificationPreferences, Subscription, Renewal) would be similar

// Example for Settings
class Settings {
  String _theme;
  NotificationPreferences _notificationPreferences;
  String _timeZone;
  String _currency;
  Subscription _subscription;

  Settings({
    required String theme,
    required NotificationPreferences notificationPreferences,
    required String timeZone,
    required String currency,
    required Subscription subscription,
  })  : _theme = theme,
        _notificationPreferences = notificationPreferences,
        _timeZone = timeZone,
        _currency = currency,
        _subscription = subscription;

  // Getters
  String get theme => _theme;
  NotificationPreferences get notificationPreferences =>
      _notificationPreferences;
  String get timeZone => _timeZone;
  String get currency => _currency;
  Subscription get subscription => _subscription;

  // JSON Serialization
  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      theme: json['theme'],
      notificationPreferences:
          NotificationPreferences.fromJson(json['notificationPreferences']),
      timeZone: json['timeZone'],
      currency: json['currency'],
      subscription: Subscription.fromJson(json['subscription']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'theme': _theme,
      'notificationPreferences': _notificationPreferences.toJson(),
      'timeZone': _timeZone,
      'currency': _currency,
      'subscription': _subscription.toJson(),
    };
  }
}

// ... Continue with the rest (NotificationPreferences, Subscription, Renewal)
class NotificationPreferences {
  bool _email;
  bool _push;

  NotificationPreferences({
    required bool email,
    required bool push,
  })  : _email = email,
        _push = push;

  // Getters
  bool get email => _email;
  bool get push => _push;

  // JSON Serialization
  factory NotificationPreferences.fromJson(Map<String, dynamic> json) {
    return NotificationPreferences(
      email: json['email'],
      push: json['push'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': _email,
      'push': _push,
    };
  }
}

class Subscription {
  bool _status;
  Renewal _renewal;

  Subscription({
    required bool status,
    required Renewal renewal,
  })  : _status = status,
        _renewal = renewal;

  // Getters
  bool get status => _status;
  Renewal get renewal => _renewal;

  // JSON Serialization
  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      status: json['status'],
      renewal: Renewal.fromJson(json['renewal']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': _status,
      'renewal': _renewal.toJson(),
    };
  }
}

class Renewal {
  bool _autoRenew;
  String _paymentMethod;
  DateTime? _lastPaymentDate;
  DateTime? _nextPaymentDate;

  Renewal({
    required bool autoRenew,
    required String paymentMethod,
    DateTime? lastPaymentDate,
    DateTime? nextPaymentDate,
  })  : _autoRenew = autoRenew,
        _paymentMethod = paymentMethod,
        _lastPaymentDate = lastPaymentDate,
        _nextPaymentDate = nextPaymentDate;

  // Getters
  bool get autoRenew => _autoRenew;
  String get paymentMethod => _paymentMethod;
  DateTime? get lastPaymentDate => _lastPaymentDate;
  DateTime? get nextPaymentDate => _nextPaymentDate;

  // JSON Serialization
  factory Renewal.fromJson(Map<String, dynamic> json) {
    return Renewal(
      autoRenew: json['autoRenew'],
      paymentMethod: json['paymentMethod'],
      lastPaymentDate: json['lastPaymentDate'] != null
          ? DateTime.parse(json['lastPaymentDate'])
          : null,
      nextPaymentDate: json['nextPaymentDate'] != null
          ? DateTime.parse(json['nextPaymentDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'autoRenew': _autoRenew,
      'paymentMethod': _paymentMethod,
      'lastPaymentDate': _lastPaymentDate?.toIso8601String(),
      'nextPaymentDate': _nextPaymentDate?.toIso8601String(),
    };
  }
}

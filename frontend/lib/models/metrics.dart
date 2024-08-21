class Metrics {
  final String _id;
  final DateTime _date;
  final int _activeUsers;
  final int _newRegistrations;
  final int _subscribedUsers;
  final int _unsubscribedUsers;
  final int _totalTransactions;
  final int _totalOrders;
  final int _totalProductsAdded;
  final double _totalRevenue;
  final double _averageOrderValue;
  final int _errorsLogged;
  final int _successfulBackups;
  final int _failedBackups;

  Metrics({
    required String id,
    required DateTime date,
    required int activeUsers,
    required int newRegistrations,
    required int subscribedUsers,
    required int unsubscribedUsers,
    required int totalTransactions,
    required int totalOrders,
    required int totalProductsAdded,
    required double totalRevenue,
    required double averageOrderValue,
    required int errorsLogged,
    required int successfulBackups,
    required int failedBackups,
  })  : _id = id,
        _date = date,
        _activeUsers = activeUsers,
        _newRegistrations = newRegistrations,
        _subscribedUsers = subscribedUsers,
        _unsubscribedUsers = unsubscribedUsers,
        _totalTransactions = totalTransactions,
        _totalOrders = totalOrders,
        _totalProductsAdded = totalProductsAdded,
        _totalRevenue = totalRevenue,
        _averageOrderValue = averageOrderValue,
        _errorsLogged = errorsLogged,
        _successfulBackups = successfulBackups,
        _failedBackups = failedBackups;

  factory Metrics.fromJson(Map<String, dynamic> json) => Metrics(
        id: json['_id'],
        date: DateTime.parse(json['date']),
        activeUsers: json['activeUsers'],
        newRegistrations: json['newRegistrations'],
        subscribedUsers: json['subscribedUsers'],
        unsubscribedUsers: json['unsubscribedUsers'],
        totalTransactions: json['totalTransactions'],
        totalOrders: json['totalOrders'],
        totalProductsAdded: json['totalProductsAdded'],
        totalRevenue: json['totalRevenue'].toDouble(),
        averageOrderValue: json['averageOrderValue'].toDouble(),
        errorsLogged: json['errorsLogged'],
        successfulBackups: json['successfulBackups'],
        failedBackups: json['failedBackups'],
      );

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'date': _date.toIso8601String(),
        'activeUsers': _activeUsers,
        'newRegistrations': _newRegistrations,
        'subscribedUsers': _subscribedUsers,
        'unsubscribedUsers': _unsubscribedUsers,
        'totalTransactions': _totalTransactions,
        'totalOrders': _totalOrders,
        'totalProductsAdded': _totalProductsAdded,
        'totalRevenue': _totalRevenue,
        'averageOrderValue': _averageOrderValue,
        'errorsLogged': _errorsLogged,
        'successfulBackups': _successfulBackups,
        'failedBackups': _failedBackups,
      };
}

import 'package:intl/intl.dart';

class Transaction {
  String _id;
  String _userId;
  String _clientId;
  // List<String> _products;
  String? _orderId;
  String _transactionNumber;
  double _amount;
  PaymentMethod _paymentMethod;
  TransactionStatus _status;
  DateTime _transactionDate;
  String? _description; // New field for description, now nullable

  Transaction({
    required String id,
    required String userId,
    required String clientId,
    // required List<String> products,
    String? orderId,
    required String transactionNumber,
    required double amount,
    required PaymentMethod paymentMethod,
    required TransactionStatus status,
    required DateTime transactionDate,
    String? description, // New parameter for description, now optional
  })  : _id = id,
        _userId = userId,
        _clientId = clientId,
        // _products = products,
        _orderId = orderId,
        _transactionNumber = transactionNumber,
        _amount = amount,
        _paymentMethod = paymentMethod,
        _status = status,
        _transactionDate = transactionDate,
        _description = description; // Initialize the new field, can be null

  String get id => _id;
  String get userId => _userId;
  String get clientId => _clientId;
  // List<String> get products => _products;
  String? get orderId => _orderId;
  String get transactionNumber => _transactionNumber;
  double get amount => _amount;
  PaymentMethod get paymentMethod => _paymentMethod;
  TransactionStatus get status => _status;
  DateTime get transactionDate => _transactionDate;
  String? get description => _description;

  // Setter for status
  set status(TransactionStatus value) {
    _status = value;
  }

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json['_id'],
        userId: json['user'],
        clientId: json['clientId'],
        // products: List<String>.from(json['product']),
        orderId: json['order'] as String?,
        transactionNumber: json['transactionNumber'],
        amount: json['amount'].toDouble(),
        paymentMethod: stringToPaymentMethod(json['paymentMethod'] as String),
        status: stringToTransactionStatus(json['status'] as String),
        transactionDate: DateTime.parse(json['transactionDate']),
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'user': _userId,
        'client': _clientId,
        // 'product': _products,
        'order': _orderId,
        'transactionNumber': _transactionNumber,
        'amount': _amount,
        'paymentMethod': _paymentMethod.toString().split('.').last,
        'status': _status.toString().split('.').last,
        'transactionDate': _transactionDate.toIso8601String(),
        'description': _description,
      };
}

enum PaymentMethod {
  CreditCard,
  Cash,
  BankTransfer,
  Online,
}

enum TransactionStatus {
  Completed,
  Pending,
  Refunded,
  Failed,
}

PaymentMethod stringToPaymentMethod(String method) {
  switch (method) {
    case 'Credit Card':
      return PaymentMethod.CreditCard;
    case 'Cash':
      return PaymentMethod.Cash;
    case 'Bank Transfer':
      return PaymentMethod.BankTransfer;
    case 'Online':
      return PaymentMethod.Online;
    default:
      throw Exception('Invalid payment method');
  }
}

TransactionStatus stringToTransactionStatus(String status) {
  switch (status) {
    case 'Completed':
      return TransactionStatus.Completed;
    case 'Pending':
      return TransactionStatus.Pending;
    case 'Refunded':
      return TransactionStatus.Refunded;
    case 'Failed':
      return TransactionStatus.Failed;
    default:
      throw Exception('Invalid transaction status');
  }
}

String formatDate(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd – HH:mm:ss').format(dateTime);
}

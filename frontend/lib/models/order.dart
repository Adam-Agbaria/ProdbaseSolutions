class Order {
  final String _id;
  final String _userId;
  final String _clientId;
  final List<OrderProductDetail> _products;
  final String _orderNumber;
  final double _totalAmount;
  final OrderStatus _status;
  DateTime _orderDate;
  DeliveryDetail _deliveryDetails;

  // Public getter methods
  String get id => _id;
  String get userId => _userId;
  String get clientId => _clientId;
  List<OrderProductDetail> get products => _products;
  String get orderNumber => _orderNumber;
  double get totalAmount => _totalAmount;
  OrderStatus get status => _status;
  DateTime get orderDate => _orderDate;
  DeliveryDetail get deliveryDetails => _deliveryDetails;

  set orderDate(DateTime newDate) {
    _orderDate = newDate;
  }

  set deliveryDetails(DeliveryDetail newDetails) {
    _deliveryDetails = newDetails;
  }

  Order({
    required String id,
    required String userId,
    required String clientId,
    required List<OrderProductDetail> products,
    required String orderNumber,
    required double totalAmount,
    required OrderStatus status,
    required DateTime orderDate,
    required DeliveryDetail deliveryDetails,
  })  : _id = id,
        _userId = userId,
        _clientId = clientId,
        _products = products,
        _orderNumber = orderNumber,
        _totalAmount = totalAmount,
        _status = status,
        _orderDate = orderDate,
        _deliveryDetails = deliveryDetails;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['_id'],
        userId: json['user'],
        clientId: json['client'],
        products: (json['products'] as List)
            .map((e) => OrderProductDetail.fromJson(e))
            .toList(),
        orderNumber: json['orderNumber'],
        totalAmount: json['totalAmount'].toDouble(),
        status: OrderStatus.values
            .firstWhere((e) => e.toString() == 'OrderStatus.${json['status']}'),
        orderDate: DateTime.parse(json['orderDate']),
        deliveryDetails: DeliveryDetail.fromJson(json['deliveryDetails']),
      );

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'user': _userId,
        'client': _clientId,
        'products': _products.map((e) => e.toJson()).toList(),
        'orderNumber': _orderNumber,
        'totalAmount': _totalAmount,
        'status': _status.toString().split('.').last,
        'orderDate': _orderDate.toIso8601String(),
        'deliveryDetails': _deliveryDetails.toJson(),
      };
}

class OrderProductDetail {
  final int _quantity;
  final double _price;
  final String _productNumber;
  final String _productName; // New field

  // Public getter methods
  int get quantity => _quantity;
  double get price => _price;
  String get productNumber => _productNumber;
  String get productName => _productName; // New getter

  OrderProductDetail({
    required int quantity,
    required double price,
    required String productNumber,
    required String productName, // New parameter
  })  : _quantity = quantity,
        _price = price,
        _productNumber = productNumber,
        _productName = productName; // Initialize new field

  factory OrderProductDetail.fromJson(Map<String, dynamic> json) =>
      OrderProductDetail(
        quantity: json['quantity'].toInt(),
        price: json['price'].toDouble(),
        productNumber: json['productNumber'],
        productName: json['productName'], // Initialize from JSON
      );

  Map<String, dynamic> toJson() => {
        'quantity': _quantity,
        'price': _price,
        'productNumber': _productNumber,
        'productName': _productName, // Add to JSON
      };
}

class DeliveryDetail {
  final String _address;
  DateTime? _deliveryDate;
  DeliveryStatus _deliveryStatus;

  // Public getter methods
  String get address => _address;
  DateTime? get deliveryDate => _deliveryDate;
  DeliveryStatus get deliveryStatus => _deliveryStatus;

  set deliveryDate(DateTime? newDate) {
    _deliveryDate = newDate;
  }

  set deliveryStatus(DeliveryStatus newStatus) {
    _deliveryStatus = newStatus;
  }

  DeliveryDetail({
    required String address,
    DateTime? deliveryDate,
    required DeliveryStatus deliveryStatus,
  })  : _address = address,
        _deliveryDate = deliveryDate,
        _deliveryStatus = deliveryStatus;

  factory DeliveryDetail.fromJson(Map<String, dynamic> json) => DeliveryDetail(
        address: json['address'],
        deliveryDate: json['deliveryDate'] != null
            ? DateTime.parse(json['deliveryDate'])
            : null,
        deliveryStatus: DeliveryStatus.values.firstWhere(
            (e) => e.toString() == 'DeliveryStatus.${json['deliveryStatus']}'),
      );

  Map<String, dynamic> toJson() => {
        'address': _address,
        'deliveryDate': _deliveryDate?.toIso8601String(),
        'deliveryStatus': _deliveryStatus.toString().split('.').last,
      };
}

enum OrderStatus { Pending, Shipped, Delivered, Cancelled }

enum DeliveryStatus { NotShipped, InTransit, Delivered }

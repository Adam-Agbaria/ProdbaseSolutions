class Profit {
  final String _id;
  final String _userId;
  final String _orderId;
  final List<ProductProfitDetail> _products;
  final String _clientId;
  final double _profitAmount;
  final DateTime _profitDate;
  final String _profitNumber;

  Profit({
    required String id,
    required String userId,
    required String orderId,
    required List<ProductProfitDetail> products,
    required String clientId,
    required double profitAmount,
    required DateTime profitDate,
    required String profitNumber,
  })  : _id = id,
        _userId = userId,
        _orderId = orderId,
        _products = products,
        _clientId = clientId,
        _profitAmount = profitAmount,
        _profitDate = profitDate,
        _profitNumber = profitNumber;

  // Public getter methods
  String get id => _id;
  String get userId => _userId;
  String get orderId => _orderId;
  List<ProductProfitDetail> get products => _products;
  String get clientId => _clientId;
  double get profitAmount => _profitAmount;
  DateTime get profitDate => _profitDate;
  String get profitNumber => _profitNumber;

  // Your existing toJson and fromJson methods remain the same
  // ...
  factory Profit.fromJson(Map<String, dynamic> json) {
    return Profit(
      id: json['_id'],
      userId: json['_userId'],
      orderId: json['_orderId'],
      products: (json['_products'] as List)
          .map((item) => ProductProfitDetail.fromJson(item))
          .toList(),
      clientId: json['_clientId'],
      profitAmount: json['_profitAmount'].toDouble(),
      profitDate: DateTime.parse(json['_profitDate']),
      profitNumber: json['_profitNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': _id,
      '_userId': _userId,
      '_orderId': _orderId,
      '_products': _products.map((e) => e.toJson()).toList(),
      '_clientId': _clientId,
      '_profitAmount': _profitAmount,
      '_profitDate': _profitDate.toIso8601String(),
      '_profitNumber': _profitNumber,
    };
  }
}

class ProductProfitDetail {
  final String _productId;
  final int _quantitySold;
  final double _profitFromProduct;

  ProductProfitDetail({
    required String productId,
    required int quantitySold,
    required double profitFromProduct,
  })  : _productId = productId,
        _quantitySold = quantitySold,
        _profitFromProduct = profitFromProduct;

  // Public getter methods
  String get productId => _productId;
  int get quantitySold => _quantitySold;
  double get profitFromProduct => _profitFromProduct;

  factory ProductProfitDetail.fromJson(Map<String, dynamic> json) =>
      ProductProfitDetail(
        productId: json['product'],
        quantitySold: json['quantitySold'].toInt(),
        profitFromProduct: json['profitFromProduct'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'product': productId,
        'quantitySold': quantitySold,
        'profitFromProduct': profitFromProduct,
      };
}

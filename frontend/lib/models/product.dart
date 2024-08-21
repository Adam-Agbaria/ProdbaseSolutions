class Product {
  final String _id;
  final String _ownerId;
  final String _productNumber;
  String _name;
  String _description;
  double _price;
  int _stock;
  final String _category;
  String? _imageUrl;
  final DateTime _dateAdded;
  DateTime _lastUpdated;

  Product({
    required String id,
    required String ownerId,
    required String productNumber,
    required String name,
    required String description,
    required double price,
    required int stock,
    required String category,
    String? imageUrl,
    required DateTime dateAdded,
    required DateTime lastUpdated,
  })  : _id = id,
        _ownerId = ownerId,
        _productNumber = productNumber,
        _name = name,
        _description = description,
        _price = price,
        _stock = stock,
        _category = category,
        _imageUrl = imageUrl,
        _dateAdded = dateAdded,
        _lastUpdated = lastUpdated;

  // Public getter methods
  String get id => _id;
  String get ownerId => _ownerId;
  String get productNumber => _productNumber;
  String get name => _name;
  String get description => _description;
  double get price => _price;
  int get stock => _stock;
  String get category => _category;
  String? get imageUrl => _imageUrl;
  DateTime get dateAdded => _dateAdded;
  DateTime get lastUpdated => _lastUpdated;

  // Setter methods with validation
  set name(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Name cannot be empty');
    }
    _name = value;
  }

  set description(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Description cannot be empty');
    }
    _description = value;
  }

  set price(double value) {
    if (value <= 0) {
      throw ArgumentError('Price must be greater than zero');
    }
    _price = value;
  }

  set stock(int value) {
    if (value < 0) {
      throw ArgumentError('Stock cannot be negative');
    }
    _stock = value;
  }

  set lastUpdated(DateTime value) {
    if (value.isBefore(_dateAdded)) {
      throw ArgumentError('Last updated date cannot be before the date added');
    }
    _lastUpdated = value;
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['_id'],
        ownerId: json['owner'],
        productNumber: json['productNumber'],
        name: json['name'],
        description: json['description'],
        price: json['price'].toDouble(),
        stock: json['stock'],
        category: json['category'],
        imageUrl: json['imageUrl'] as String?,
        dateAdded: DateTime.parse(json['dateAdded']),
        lastUpdated: DateTime.parse(json['lastUpdated']),
      );

  Map<String, dynamic> toJson() {
    // Base map without nullable imageUrl
    var map = {
      '_id': _id,
      'owner': _ownerId,
      'productNumber': _productNumber,
      'name': _name,
      'description': _description,
      'price': _price,
      'stock': _stock,
      'category': _category,
      'dateAdded': _dateAdded.toIso8601String(),
      'lastUpdated': _lastUpdated.toIso8601String(),
    };

    // Add imageUrl to map if it's not null
    if (_imageUrl != null) {
      map['imageUrl'] = _imageUrl!;
    }

    return map;
  }
}

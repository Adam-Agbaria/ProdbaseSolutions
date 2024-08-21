class Client {
  // Private Fields
  final String _id;
  final String _owner;
  final String _clientNumber;
  String _name;
  String? _email;
  String? _phoneNumber;
  Address? _address;
  String? _notes;
  final DateTime _dateAdded;
  final DateTime _lastUpdated;

  // Constructor
  Client({
    required String id,
    required String owner,
    required String clientNumber,
    required String name,
    String? email,
    String? phoneNumber,
    Address? address,
    String? notes,
    required DateTime dateAdded,
    required DateTime lastUpdated,
  })  : _id = id,
        _owner = owner,
        _clientNumber = clientNumber,
        _name = name,
        _email = email,
        _phoneNumber = phoneNumber,
        _address = address,
        _notes = notes,
        _dateAdded = dateAdded,
        _lastUpdated = lastUpdated;

  // Getters
  String get id => _id;
  String get ownerId => _owner;
  String get clientNumber => _clientNumber;
  String get name => _name;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  Address? get address => _address;
  String? get notes => _notes;
  DateTime get dateAdded => _dateAdded;
  DateTime get lastUpdated => _lastUpdated;

  // Setters
  set name(String? value) {
    if (value != null && value.isNotEmpty) {
      _name = value;
    } else {
      throw ArgumentError('The name value cannot be null or empty.');
    }
  }

  set email(String? value) {
    _email = value;
  }

  set phoneNumber(String? value) {
    _phoneNumber = value;
  }

  set address(Address? value) {
    _address = value;
  }

  set notes(String? value) {
    _notes = value;
  }

  // Setter for lastUpdated
  set lastUpdated(DateTime value) {
    this.lastUpdated = value;
  }

  // JSON Serialization and Deserialization
  static Client fromJson(Map<String, dynamic> json) => Client(
        id: json['_id'],
        owner: json['ownerId'] ?? '',
        clientNumber: json['clientNumber'],
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        address:
            json['address'] != null ? Address.fromJson(json['address']) : null,
        notes: json['notes'] ?? '',
        dateAdded: DateTime.parse(json['dateAdded']),
        lastUpdated: DateTime.parse(json['lastUpdated']),
      );

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'owner': _owner,
        'clientNumber': _clientNumber,
        'name': _name,
        'email': _email,
        'phoneNumber': _phoneNumber,
        'address': _address?.toJson(),
        'notes': _notes,
        'dateAdded': _dateAdded.toIso8601String(),
        'lastUpdated': _lastUpdated.toIso8601String(),
      };
}

class Address {
  String? _street;
  String? _city;
  String? _postalCode;
  String? _country;

  Address({
    String? street,
    String? city,
    String? postalCode,
    String? country,
  })  : _street = street,
        _city = city,
        _postalCode = postalCode,
        _country = country;

  // Getters
  String? get street => _street;
  String? get city => _city;
  String? get postalCode => _postalCode;
  String? get country => _country;

  // Setters
  set street(String? value) {
    _street = value;
  }

  set city(String? value) {
    _city = value;
  }

  set postalCode(String? value) {
    _postalCode = value;
  }

  set country(String? value) {
    _country = value;
  }

  // JSON Serialization and Deserialization
  static Address fromJson(Map<String, dynamic> json) => Address(
        street: json['street'],
        city: json['city'],
        postalCode: json['postalCode'],
        country: json['country'],
      );

  Map<String, dynamic> toJson() => {
        'street': _street,
        'city': _city,
        'postalCode': _postalCode,
        'country': _country,
      };
}

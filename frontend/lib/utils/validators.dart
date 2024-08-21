import 'dart:io';

class Validators {
  // Email Validator
  String? validateEmail(String value) {
    RegExp regex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!regex.hasMatch(value)) {
      return 'Invalid email address';
    } else {
      return null; // valid
    }
  }

  String? validatePassword(String? password) {
    if (password == null || password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[a-zA-Z]').hasMatch(password)) {
      return 'Password must contain at least one letter';
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }
    return null; // Return null if the password is valid
  }

  String? validateCompanyName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Company name is required';
    }
    if (name.length < 2) {
      return 'Company name must be at least 2 characters long';
    }
    if (name.length > 25) {
      return 'Company name must not exceed 25 characters';
    }
    if (!RegExp(r'^[A-Z]').hasMatch(name)) {
      return 'The first letter of the company name must be uppercase';
    }
    if (!RegExp(r'^[A-Za-z\s]+$').hasMatch(name)) {
      return 'Company name can only contain letters and spaces';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    // Check if the length is between 4 and 16 characters
    if (value.length < 4 || value.length > 16) {
      return 'Username must be between 4 and 16 characters';
    }

    // Check if the username contains only allowed characters (letters, numbers, underscores, and scores)
    final pattern = RegExp(r'^[a-zA-Z0-9-_]+$');
    if (!pattern.hasMatch(value)) {
      return 'Username can only contain letters, numbers, scores, and underscores';
    }

    return null; // Return null if the value is valid
  }

  // URL Validator
  static String? validateUrl(String value) {
    RegExp regex =
        RegExp(r"^((http|https):\/\/)?(www\.)([a-zA-Z0-9]+)\.([a-zA-Z]{2,3})");
    if (!regex.hasMatch(value)) {
      return 'Invalid URL';
    } else {
      return null; // valid
    }
  }

  // IP Address Validator
  static String? validateIP(String value) {
    RegExp regex = RegExp(
        r"^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$");
    if (!regex.hasMatch(value)) {
      return 'Invalid IP address';
    } else {
      return null; // valid
    }
  }

  // Photo Validator
  // Note: This one is a bit tricky in Flutter. Typically, you would validate after selecting the image using a package like `image_picker`.
  static String? validatePhoto(File? imageFile) {
    if (imageFile == null) {
      return 'A photo is required.';
    }
    // You can add more validation logic based on file type, size, etc.
    else {
      return null; // valid
    }
  }
}

class BarcodeValidators {
  String? lastScannedBarcode;

  BarcodeValidators();

  bool isValidBarcode(String barcode) {
    // Example: UPC-A validation
    if (barcode.length != 16) {
      return false;
    }

    if (!RegExp(r'^[A-Za-z0-9]+$').hasMatch(barcode)) {
      return false;
    }

    // int checksum = 0;
    // for (int i = 0; i < barcode.length; i++) {
    //   int digit = int.parse(barcode[i]);
    //   if (i % 2 == 0) {
    //     // even-indexed (0-based) digit
    //     checksum += digit;
    //   } else {
    //     // odd-indexed digit
    //     checksum += digit * 3;
    //   }
    // }
    // if (checksum % 10 != 0) {
    //   return false;
    // }

    return true;
  }

  /// Scenario 2: Check for Duplicate Scan
  bool isDuplicateScan(String barcode) {
    if (barcode == lastScannedBarcode) {
      return true;
    }
    lastScannedBarcode = barcode;
    return false;
  }

  /// Scenario 3: Lookup Product Information
  // Product? findProductByBarcode(String barcode) {
  //   // Replace with actual lookup logic
  //   // For demonstration, assuming a Product class exists
  //   return Product(barcode: barcode, name: "Sample Product");
  // }

  /// Scenario 4: Add to Cart
  // void addToCart(Product product) {
  //   // Add product to cart
  //   print("Added ${product.name} to cart.");
  // }

  /// Scenario 5: Check Inventory
  // bool isInStock(Product product) {
  //   // Replace with actual inventory check
  //   return true;
  // }

  /// Scenario 6: Authentication
  // bool isAuthenticationBarcode(String barcode) {
  //   // Replace with actual authentication logic
  //   return false;
  // }

  /// Handle the scanned barcode
  void handleScannedBarcode(String barcode) {
    if (!isValidBarcode(barcode)) {
      print("Invalid barcode");
      return;
    }

    if (isDuplicateScan(barcode)) {
      print("Duplicate scan");
      return;
    }

    // Product? product = findProductByBarcode(barcode);
    // if (product == null) {
    //   print("Product not found");
    //   return;
    // }

    // if (!isInStock(product)) {
    //   print("Item out of stock");
    //   return;
    // }

    // addToCart(product);

    // if (isAuthenticationBarcode(barcode)) {
    //   print("Authenticated");
    // }

    print("Successfully handled barcode: $barcode");
  }
}

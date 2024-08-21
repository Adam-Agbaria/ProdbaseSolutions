import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../widgets/product_add_widget.dart'; // Make sure to import your ProductListWidget

class ProductAddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          ProductAddWidget(), // Your existing ProductListWidget is the body here
    );
  }
}

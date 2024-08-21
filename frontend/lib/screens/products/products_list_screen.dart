import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../widgets/product_list_widget.dart'; // Make sure to import your ProductListWidget

class ProductsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          ProductListWidget(), // Your existing ProductListWidget is the body here
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../widgets/product_update_widget.dart'; // Import your ProductUpdateWidget

class ProductUpdateScreen extends StatelessWidget {
  final String productId;

  ProductUpdateScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductUpdateWidget(
          productId:
              productId), // Initialize the ProductUpdateWidget with the product ID
    );
  }
}

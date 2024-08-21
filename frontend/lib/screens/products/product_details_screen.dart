import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../widgets/product_detail_widget.dart'; // Import your ProductDetailWidget

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  ProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductDetailWidget(
          productId:
              productId), // Initialize the ProductDetailWidget with the product ID
    );
  }
}

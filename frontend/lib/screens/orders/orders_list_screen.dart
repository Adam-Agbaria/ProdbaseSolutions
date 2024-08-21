import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../widgets/order_list_widget.dart'; // Import the OrdersListWidget

class OrdersListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrdersListWidget(), // Initialize the OrdersListWidget
    );
  }
}

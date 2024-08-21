import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../widgets/transaction_update_widget.dart'; // Import your TransactionUpdateWidget

class TransactionUpdateScreen extends StatelessWidget {
  final String transactionId;

  TransactionUpdateScreen({required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TransactionUpdateWidget(
          transactionId:
              transactionId), // Initialize the TransactionUpdateWidget with the transaction ID
    );
  }
}

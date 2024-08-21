import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../widgets/transaction_detail_widget.dart'; // Import your TransactionDetailWidget

class TransactionDetailScreen extends StatelessWidget {
  final String transactionId;

  TransactionDetailScreen({required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TransactionDetailWidget(
          transactionId:
              transactionId), // Initialize the TransactionDetailWidget with the transaction ID
    );
  }
}

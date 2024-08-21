import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../widgets/transaction_add_widget.dart'; // Import your TransactionsListWidget

class TransactionAddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TransactionAddWidget(), // Initialize the TransactionsListWidget
    );
  }
}

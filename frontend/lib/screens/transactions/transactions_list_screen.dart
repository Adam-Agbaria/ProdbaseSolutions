import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../widgets/transactions_list_widget.dart'; // Import your TransactionsListWidget

class TransactionsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TransactionListWidget(), // Initialize the TransactionsListWidget
    );
  }
}

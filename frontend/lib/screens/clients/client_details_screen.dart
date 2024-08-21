import 'package:flutter/material.dart';
import '../../widgets/client_detail_widget.dart'; // Import your ClientDetailWidget

class ClientDetailScreen extends StatelessWidget {
  final String clientId;

  ClientDetailScreen({required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientDetailWidget(
          clientId: clientId), // Initialize the ClientDetailWidget
    );
  }
}

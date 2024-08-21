import 'package:flutter/material.dart';
import '../../widgets/client_update_widget.dart'; // Import your ClientUpdateWidget

class ClientUpdateScreen extends StatelessWidget {
  final String clientId;

  ClientUpdateScreen({required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientUpdateWidget(
          clientId: clientId), // Initialize the ClientUpdateWidget
    );
  }
}

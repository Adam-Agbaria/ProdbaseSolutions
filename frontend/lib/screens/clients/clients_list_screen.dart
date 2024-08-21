import 'package:flutter/material.dart';
import '../../widgets/clients_list_widget.dart'; // Import your ClientsListWidget

class ClientsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientsListWidget(), // Initialize the ClientsListWidget
    );
  }
}

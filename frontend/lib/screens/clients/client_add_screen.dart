import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../widgets/client_add_widget.dart'; // Make sure to import your ProductListWidget

class ClientAddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          ClientAddWidget(), // Your existing ProductListWidget is the body here
    );
  }
}

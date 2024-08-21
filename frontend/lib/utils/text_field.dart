import 'package:flutter/material.dart';

class StyledTextField extends StatelessWidget {
  final String labelText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  StyledTextField({
    required this.labelText,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}

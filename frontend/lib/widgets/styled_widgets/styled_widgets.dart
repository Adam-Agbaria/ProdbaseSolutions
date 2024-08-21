import 'package:ProdBase_Solutions/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../utils/theme_colors.dart';

class StyledTextField extends StatelessWidget {
  final String? labelText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hintText;
  final TextEditingController? controller; // add this line

  final void Function(String?)? onSaved;

  StyledTextField({
    this.labelText,
    this.keyboardType,
    this.hintText,
    this.validator,
    this.onSaved,
    this.controller, // add this line
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        // labelText: labelText,
        hintText: labelText,
        hintStyle: TextStyle(fontSize: 14),
      ),
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
      controller: controller, // add this line
    );
  }
}

Widget buildTextField({
  required String labelText,
  required String hintText,
  required String? Function(String?) validator,
  required void Function(String?) onSaved,
  Color textFieldColor = Colors.white,
  TextInputType keyboardType = TextInputType.text,
}) {
  final double textFieldHeight = textFieldSize().addCardFieldSize;
  textFieldColor = AddClientColors().textFieldColorLight;
  return Neumorphic(
    style: NeumorphicStyle(
      depth: 1,
      color: textFieldColor,
      boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(12),
      ),
    ),
    child: Container(
      height: textFieldHeight,
      // Set width to half of screen width, accounting for padding
      child: StyledTextField(
        labelText: labelText,
        hintText: hintText,
        validator: validator,
        onSaved: onSaved,
        keyboardType: keyboardType,
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class animatedTextColors {
  Color waveColors = Colors.black; // Changed to black as per your request
}

class HomeColors {
//Home background
  Color homeBackgroundLight = Color(0xFFFAF3E0);
  Color homeBackgroundDark = Color(0xFF3E3E3E);

//Home Cards
  Color homeCards = Color(0xFFE1D5B2);

//Home Quick Action Buttons
  Color addClientHomeButton =
      Color(0xFF6D72C3); // Unified and slightly darker shade
  Color addProductHomeButton = Color(0xFF6D72C3); // Unified
  Color addTransactionHomeButton = Color(0xFF6D72C3); // Unified
  Color addOrderHomeButton = Color(0xFF6D72C3); // Unified
}

// Add Client Section Colors
class AddClientColors {
  Color addClientRectangleColorLight = Color(0xFF6D72C3);
  Color textFieldColorLight = Color(0xFF4D5AB7);
  Color textColorTitleLight = Colors.white;
  Color buttonColorLight = Color(0xFF6D72C3).withOpacity(0.7);
  Color buttonHoveringColorLight = Color(0xFF4D5AB7);

  Color addClientRectangleColorDark = Color(0xFF4D5AB7);
  Color textFieldColorDark = Color(0xFF6D72C3);
  Color textColorTitleDark = Colors.white;
  Color textColorInField = Colors.white70;
  Color buttonColorDark = Color(0xFF6D72C3);
  Color buttonHoveringColorDark = Color(0xFF4D5AB7);
}

// Add Product Section Colors
class AddProductColors {
  Color addProductRectangleColorLight = Color(0xFF6D72C3);
  Color textFieldColorLight = Color(0xFF4D5AB7);
  Color textColorTitleLight = Colors.white;
  Color buttonColorLight = Color(0xFF6D72C3).withOpacity(0.7);
  Color buttonHoveringColorLight = Color(0xFF4D5AB7);

  Color addProductRectangleColorDark = Color(0xFF4D5AB7);
  Color textFieldColorDark = Color(0xFF6D72C3);
  Color textColorTitleDark = Colors.white;
  Color textColorInField = Colors.white70;
  Color buttonColorDark = Color(0xFF6D72C3);
  Color buttonHoveringColorDark = Color(0xFF4D5AB7);
}

// Add Transaction Section Colors
class AddTransactionColors {
  Color addTransactionRectangleColorLight = Color(0xFF6D72C3);
  Color textFieldColorLight = Color(0xFF4D5AB7);
  Color textColorTitleLight = Colors.white;
  Color buttonColorLight = Color(0xFF6D72C3).withOpacity(0.7);
  Color buttonHoveringColorLight = Color(0xFF4D5AB7);

  Color addTransactionRectangleColorDark = Color(0xFF4D5AB7);
  Color textFieldColorDark = Color(0xFF6D72C3);
  Color textColorTitleDark = Colors.white;
  Color textColorInField = Colors.white70;
  Color buttonColorDark = Color(0xFF6D72C3);
  Color buttonHoveringColorDark = Color(0xFF4D5AB7);
}

class AddOrdersColors {}

class clientListColor {
  Color cardColor = Color(0xFFE1D5B2);
  Color textColor = Colors.black;
}

class productListColor {
  Color cardColor = Color(0xFFE1D5B2);
  Color textColor = Colors.black;
}

class transactionListColor {
  Color cardColor =
      Color(0xFFE1D5B2); // Complementary to the new background color
  Color textColor = Colors.black87; // Readable on top of the card color
}

class buttonColors {
  Color generalButtonColor = Color(0xFFE1D5B2);
  Color generalButtonColorHover = Color.fromARGB(255, 227, 219, 196);
}

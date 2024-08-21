import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../utils/theme_colors.dart';

class AnimatedCompanyName extends StatelessWidget {
  final String companyName;
  final NeumorphicThemeData theme;

  AnimatedCompanyName({required this.companyName, required this.theme});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double fontSize = screenWidth * 0.15; // 10% of screen width
    // fontSize = fontSize.clamp(25.0, 87.0); // Clamp between 5 and 87

    double boxWidth = screenWidth; // 95% of screen width
    double boxHeight = screenHeight * 0.24; // 25% of screen height

    String fontFamily = 'CroissantOne';
    if (screenWidth < 300) {
      fontFamily = 'Lobster';
      boxHeight = screenHeight * 0.15;
    } else {
      boxHeight = screenHeight * 0.24;
    }
    int nameLength = companyName.length;

    FontWeight textWeight = FontWeight.normal;

    if (nameLength >= 0 && nameLength <= 7) {
      // fontSize = 87.0;
      fontSize = boxWidth * 0.07;
      fontSize = fontSize.clamp(29.0, 87.0); // Individual clamp
      textWeight = FontWeight.bold;
    } else if (nameLength >= 8) {
      // fontSize = 60.0;
      fontSize = boxWidth * 0.07;
      fontSize = fontSize.clamp(25.0, 87.0); // Individual clamp
      textWeight = FontWeight.bold;
    } else if (nameLength >= 8 && nameLength <= 9) {
      // fontSize = 60.0;
      fontSize = boxWidth * 0.07;
      fontSize = fontSize.clamp(24.0, 87.0); // Individual clamp
    } else if (nameLength >= 10) {
      // fontSize = 60.0;
      fontSize = boxWidth * 0.07;
      fontSize = fontSize.clamp(23.0, 87.0); // Individual clamp
    } else if (nameLength <= 11) {
      // fontSize = 60.0;
      fontSize = boxWidth * 0.07;
      fontSize = fontSize.clamp(22.0, 87.0); // Individual clamp
    } else if (nameLength >= 12 && nameLength <= 13) {
      // fontSize = 50.0;
      fontSize = boxWidth * 0.08; // 10% of screen width

      fontSize = fontSize.clamp(21.0, 87.0); // Individual clamp
    } else if (nameLength >= 14 && nameLength <= 15) {
      // fontSize = 50.0;
      fontSize = boxWidth * 0.05; // 10% of screen width

      fontSize = fontSize.clamp(20.0, 87.0); // Individual clamp
    } else if (nameLength >= 16 && nameLength <= 18) {
      // fontSize = 50.0;
      fontSize = boxWidth * 0.03; // 10% of screen width

      fontSize = fontSize.clamp(16.0, 87.0); // Individual clamp
    } else {
      fontSize = screenWidth * 0.1; // Default
      fontSize = fontSize.clamp(25.0, 45.0); // Default clamp
    }

    return TextLiquidFill(
      text: companyName,
      waveColor: animatedTextColors().waveColors,
      boxBackgroundColor: theme.baseColor,
      loadDuration: Duration(seconds: 14),
      waveDuration: Duration(seconds: 2),
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: textWeight,
        fontFamily: fontFamily, // specify the custom font
      ),
      boxHeight: boxHeight,
      boxWidth: boxWidth,
    );
  }
}

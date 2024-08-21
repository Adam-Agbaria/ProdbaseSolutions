import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../utils/theme_colors.dart';

class HoverButton extends StatefulWidget {
  final NeumorphicThemeData theme;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final IconData icon;
  final String? navigationPlace;

  HoverButton({
    required this.theme,
    required this.scaffoldKey,
    required this.icon,
    this.navigationPlace,
  });

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  Color buttonColor = buttonColors().generalButtonColor;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = (0.04 * screenWidth).clamp(4.0, 24.0); // Using .clamp()

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          buttonColor = buttonColors().generalButtonColorHover;
        });
      },
      onExit: (_) {
        setState(() {
          buttonColor = buttonColors().generalButtonColor;
        });
      },
      child: ElevatedButton(
        onPressed: () {
          // Added the condition here
          if (widget.navigationPlace != null &&
              widget.navigationPlace!.isNotEmpty) {
            Navigator.pushNamed(context, widget.navigationPlace!);
          } else if (widget.icon == Icons.delete) {
            // Delete functionality here
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Are you sure you want to delete this ?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Add your delete logic here
                      Navigator.of(context).pop();
                    },
                    child: Text('Delete'),
                  ),
                ],
              ),
            );
          } else {
            widget.scaffoldKey.currentState?.openDrawer();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          minimumSize: Size(iconSize * 2, iconSize * 2.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Icon(
          widget.icon,
          color: widget.theme.defaultTextColor,
          size: iconSize,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Color? color;
  final double? size;

  LoadingIndicator({this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).primaryColor,
          strokeWidth: 5.0, // The width of the circle line
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? Theme.of(context).primaryColor,
          ),
        ),
        width: size ?? 50.0,
        height: size ?? 50.0,
        padding: EdgeInsets.all(10.0),
      ),
    );
  }
}

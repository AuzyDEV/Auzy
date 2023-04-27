import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final Color color;
  final double thickness;
  final double height;

  CustomDivider({this.color = Colors.grey, this.thickness = 1.0, this.height = 16.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Divider(
        color: color,
        thickness: thickness,
      ),
    );
  }
}
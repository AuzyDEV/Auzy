import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;

  const CustomDivider(
      {Key key,
      this.height,
      this.thickness,
      this.color,
      this.indent,
      this.endIndent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: color,
            width: 1 ?? thickness,
          ),
        ),
      ),
      color: Colors.grey ?? color,
      margin:
          EdgeInsetsDirectional.only(start: 50 ?? indent, end: 50 ?? endIndent),
    );
  }
}

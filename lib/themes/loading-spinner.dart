import 'package:flutter/material.dart';
import 'theme.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  final Color color;
  final double strokeWidth;

  const CircularProgressIndicatorWidget({
    Key key,
    this.color,
    this.strokeWidth = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? FlutterAppTheme.of(context).primaryColor,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

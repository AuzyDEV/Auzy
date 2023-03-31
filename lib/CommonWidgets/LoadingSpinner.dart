import 'package:flutter/material.dart';

import '../themes/theme.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  final Color color;
  final double strokeWidth;

  const CircularProgressIndicatorWidget({
    Key key,
    this.color,
    this.strokeWidth = 3.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: FlutterAppTheme.of(context).primaryColor,
      strokeWidth: strokeWidth,
    ));
  }
}

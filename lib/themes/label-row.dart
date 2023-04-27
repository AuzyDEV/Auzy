import 'package:flutter/material.dart';
import 'theme.dart';

class LabeledRowWidget extends StatelessWidget {
  final String text;

  const LabeledRowWidget({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
          Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
       child: Text(
          '$text*',
          style: FlutterAppTheme.of(context).bodyText2.override(
                fontFamily: 'Roboto',
                color: FlutterAppTheme.of(context).TextColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
        ),
          ),
      ],
    );
  }
}

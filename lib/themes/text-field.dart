import 'package:flutter/material.dart';

import '../themes/theme.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String Function(String) validator;
  final int maxLines;
  final bool obscureText, readOnly;

  const TextFormFieldWidget(
      {Key key,
      this.hintText,
      this.controller,
      this.onChanged,
      this.validator,
      this.maxLines,
      this.obscureText,
      this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        onChanged: onChanged,
        readOnly: readOnly ?? false,
        validator: validator ?? _defaultValidator,
        maxLines: maxLines ?? 1,
        obscureText: obscureText ?? false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: FlutterAppTheme.of(context).primaryColor,
        decoration: InputDecoration(
          errorStyle: FlutterAppTheme.of(context).bodyText1.override(
                fontFamily: 'Roboto',
                color: Colors.red,
                fontWeight: FontWeight.normal,
              ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x988B97A2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x988B97A2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hintText,
          hintStyle: FlutterAppTheme.of(context).bodyText1.override(
                fontFamily: 'Roboto',
                color: Color(0xFF9DA3A9),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
        ),
        style: FlutterAppTheme.of(context).bodyText1.override(
            fontFamily: 'Roboto',
            color: Colors.black,
            fontWeight: FontWeight.normal));
  }

  String _defaultValidator(String value) {
    if (value == null || value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }
}

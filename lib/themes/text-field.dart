import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import '../themes/theme.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String Function(String) validator;
  final int maxLines;
  final bool obscureText, readOnly;
  final bool isRequired;
  final bool isNumeric;
  final bool isEmail;
  final bool isString;
  final bool isPassword;

  const TextFormFieldWidget(
      {Key key,
      this.hintText,
      this.controller,
      this.onChanged,
      this.maxLines,
      this.obscureText,
      this.readOnly,
      this.validator,
      this.isRequired = false,
      this.isNumeric = false,
      this.isEmail = false,
      this.isString = false,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        readOnly: readOnly ?? false,
        validator: validator ?? _validateField,
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
            fontWeight: FontWeight.normal)
      ),
    );
  }

  String _validateField(String value) {
    if (isRequired && (value == null || value.isEmpty)) {
      return 'Field is required';
    }
    if (isNumeric && value != null) {
      final numericValue = num.tryParse(value);
      if (numericValue == null) {
        return 'Field must be a number';
      }
    }
    if (isString && value != null) {
      if (value == null || value.isEmpty) {
        return 'Field is required';
      }
      if (!isAlpha(value.replaceAll(' ', ''))) {
        return 'Requires only characters';
      }
      if (value.length < 3) {
        return 'Requires at least 3 characters.';
      }
    }
    if (isPassword && value != null) {
      if (value == null || value.isEmpty) {
        return 'Field is required';
      }
      if (value.length < 6) {
        return 'Requires at least 6 characters.';
      }
    }
    if (isEmail && value != null && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) 
    {
      return 'Please enter a valid email address';
    }
    return null;
  }
}

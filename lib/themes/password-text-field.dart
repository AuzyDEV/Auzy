import 'package:flutter/material.dart';
import 'package:skeleton/themes/theme.dart';

class PasswordFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool autoFocus;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String Function(String) validator;

  PasswordFormField({
    this.labelText,
    this.hintText,
    this.autoFocus = false,
    this.controller,
    this.validator,
    this.onChanged,
  });

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscureText = true;
  TextEditingController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
        child: TextFormField(
          autofocus: widget.autoFocus,
          controller: _controller,
          focusNode: _focusNode,
          obscureText: _obscureText,
          onChanged: widget.onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: FlutterAppTheme.of(context).primaryColor,
          style: FlutterAppTheme.of(context).bodyText1.override(
              fontFamily: 'Roboto',
              color: Colors.black,
              fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
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
            hintStyle: FlutterAppTheme.of(context).bodyText1.override(
                  fontFamily: 'Roboto',
                  color: Color(0xFF9DA3A9),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
            suffixIcon: IconButton(
              iconSize: 23,
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                  _focusNode.requestFocus();
                });
              },
            ),
          ),
          validator: widget.validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Field is required';
                }

                return null;
              },
        ));
  }
}

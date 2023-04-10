import 'package:flutter/material.dart';
import 'package:new_mee/themes/theme.dart';

class ReusableDropdown extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final ValueChanged onChanged;

  ReusableDropdown({
    Key key,
    @required this.items,
    this.hintText = '',
    this.onChanged,
  }) : super(key: key);

  @override
  _ReusableDropdownState createState() => _ReusableDropdownState();
}

class _ReusableDropdownState extends State<ReusableDropdown> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: dropdownValue,
      items: widget.items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: widget.onChanged != null
          ? (String value) {
              setState(() {
                dropdownValue = value;
              });
              widget.onChanged(value);
            }
          : null,
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
        contentPadding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
      ),
      elevation: 2,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      isDense: true,
      iconSize: 18.0,
      iconEnabledColor: Colors.grey,
      validator: (value) => value == null ? 'Field is required' : null,
    );
  }
}

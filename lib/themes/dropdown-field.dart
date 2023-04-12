import 'package:flutter/material.dart';
import '../themes/theme.dart';

class FlutterFlowDropDown extends StatefulWidget {
  const FlutterFlowDropDown({
    this.initialOption,
    this.hintText,
    @required this.options,
    @required this.onChanged,
    this.icon,
    this.width,
    this.height,
    this.fillColor,
    this.textStyle,
    this.elevation,
    this.borderWidth,
    this.borderRadius,
    this.borderColor,
    this.margin,
    this.hidesUnderline = false,
  });

  final String initialOption;
  final String hintText;
  final List<String> options;
  final Function(String) onChanged;
  final Widget icon;
  final double width;
  final double height;
  final Color fillColor;
  final TextStyle textStyle;
  final double elevation;
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;
  final EdgeInsetsGeometry margin;
  final bool hidesUnderline;

  @override
  State<FlutterFlowDropDown> createState() => _FlutterFlowDropDownState();
}

class _FlutterFlowDropDownState extends State<FlutterFlowDropDown> {
  String dropDownValue;
  List<String> get effectiveOptions =>
      widget.options.isEmpty ? ['[Option]'] : widget.options;

  @override
  void initState() {
    super.initState();
    dropDownValue = widget.initialOption;
  }

  @override
  Widget build(BuildContext context) {
    final dropdownWidget = DropdownButtonFormField<String>(
      validator: (value) => value == null ? 'Field is required' : null,
      value: effectiveOptions.contains(dropDownValue) ? dropDownValue : null,
      hint: widget.hintText != null
          ? Text(widget.hintText, style: widget.textStyle)
          : null,
      items: effectiveOptions
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: widget.textStyle,
                ),
              ))
          .toList(),
      elevation: 1,
      onChanged: (value) {
        dropDownValue = value;
        widget.onChanged(value);
      },
      icon: widget.icon,
      isExpanded: true,
      dropdownColor: Colors.white,
      focusColor: FlutterAppTheme.of(context).TransparentColor,
    );
    final childWidget = InputDecorator(
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
      child: Padding(
        padding: widget.margin,
        child: widget.hidesUnderline
            ? DropdownButtonHideUnderline(child: dropdownWidget)
            : dropdownWidget,
      ),
    );
    if (widget.height != null || widget.width != null) {
      return Container(
          width: widget.width, height: widget.height, child: childWidget);
    }
    return childWidget;
  }
}

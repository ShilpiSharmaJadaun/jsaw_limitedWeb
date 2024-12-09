import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../utils/app_color.dart';

class InputField extends StatefulWidget {

  final TextEditingController? controller;
  final String hintText;
  final IconData? icon;
  final bool obscureText;
  final DeviceScreenType _deviceType;

  const   InputField({Key? key, required this.controller, required this.hintText, this.icon, required this.obscureText}) :
        _deviceType = DeviceScreenType.desktop,
        super(key: key);

  const   InputField.mobile({Key? key, required this.controller, required this.hintText, this.icon, required this.obscureText}) :
        _deviceType = DeviceScreenType.mobile,
        super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.transparent,
      shape: _border(),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        textAlign: TextAlign.start,
        style: const TextStyle(
            fontSize:  18,
            fontWeight: FontWeight.bold,
            color: kcWhite
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,

          prefixIcon: Icon(widget.icon, color: kcWhite,),
            suffixIcon: widget.obscureText
                ? IconButton(
              iconSize: 20,
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.white,
              ),
              onPressed: _toggleVisibility,
            )
                : null,
          contentPadding: const EdgeInsets.only(bottom: 10, left: 10),
          hintStyle:  TextStyle(
            fontSize: widget._deviceType.isMobile ? 10 : 12,
            color: kcWhite
          ),
          fillColor: Colors.transparent,
          filled: true,
          border: _border(),
          focusedBorder: _border(),
          enabledBorder: _border()
        ),
      ),
    );
  }

  _border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide:  BorderSide(color: Colors.white,width: 1.5)
  );
}

extension _DeviceTypeExt on DeviceScreenType {
  bool get isMobile => this == DeviceScreenType.mobile;
}
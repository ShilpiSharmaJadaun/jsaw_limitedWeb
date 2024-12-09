import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jsaw_limited/utils/app_color.dart';

class SearchBarTextField extends StatefulWidget {
  const SearchBarTextField({
    required this.onSearchChanged,
    required this.hintText,
    this.text = '',
    this.error,
    this.isPassword = false,
    this.borderColor = Colors.black,
    this.icon = Icons.search,
    Key? key,
  }) : super(key: key);

  final void Function(String) onSearchChanged;
  final String hintText;
  final String? error;
  final bool isPassword;
  final Color borderColor;
  final IconData icon;
  final String text;

  @override
  State<SearchBarTextField> createState() => _SearchBarTextFieldState();
}

class _SearchBarTextFieldState extends State<SearchBarTextField> {
  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 8, top: 8),
          child: TextField(
            controller: controller,
            onChanged: widget.onSearchChanged,
            obscureText: widget.isPassword,
            decoration: InputDecoration(
              hintText: widget.hintText,
              fillColor: Colors.white,
              hintStyle: const TextStyle(color: kcDarkGreyColor),
              filled: true,
              prefixIcon: Icon(widget.icon,color: kcLightGrey,),
              contentPadding: EdgeInsets.all(15),
              focusedBorder: _border(),
              disabledBorder: _border(),
              enabledBorder: _border(),
            ),
          ),
        ),
        _buildErrorText()
      ],
    );
  }

  _buildErrorText() {
    if (widget.error == null) return SizedBox(height: 10);
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 15, bottom: 10),
      child: Text(widget.error!, style: const TextStyle(color: Colors.white)),
    );
  }

  _border() => OutlineInputBorder(
    // borderRadius: BorderRadius.circular(20.dh),
      borderSide:  const BorderSide(color: kcLightGrey));
}
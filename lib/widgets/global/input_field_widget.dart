import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({
    super.key,
    required this.lableText,
    required this.icon,
    required this.obscureText,
    required this.textEditingController,
  });

  final String lableText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obscureText,
      decoration: InputDecoration(labelText: lableText, prefixIcon: Icon(icon)),
    );
  }
}

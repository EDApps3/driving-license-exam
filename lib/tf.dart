import 'package:flutter/material.dart';

class TextFieldApp extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;

  const TextFieldApp({
    super.key,
    required this.controller,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            controller.text=('0');
            if (onChanged != null) {
              onChanged!('0');
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TextFieldApp extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? max;

  const TextFieldApp({
    super.key,
    required this.controller,
    this.onChanged,
    this.max
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            (max!=null)?IconButton(
              icon: const Icon(Icons.checklist_rtl_outlined),
              onPressed: () {
                controller.text=max!;
                if (onChanged != null) {
                  onChanged!(max!);
                }
              },
            ): const SizedBox(),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller.text=('0');
                if (onChanged != null) {
                  onChanged!('0');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class GlobalTextForm extends StatelessWidget {
  bool? enabled;
  String hint;
  TextInputType? textInputType;
  TextEditingController controller;
  void Function(String)? onChanged;

  GlobalTextForm({
    super.key,
    this.enabled,
    this.textInputType,
    required this.hint,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged:onChanged,
      keyboardType: textInputType,
      controller: controller,
      enabled: enabled,
      validator: (v) {
        if (controller.text.isEmpty) {
          return "please enter $hint";
        }
      },
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}

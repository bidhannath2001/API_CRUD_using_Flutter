import 'package:flutter/material.dart';

class Textfieldwidget {
  static Widget textfield(String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 16),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFBDBDBD),
              width: 1.3,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFF4E12F5),
              width: 2,
            ),
          ),

          // Label style
          labelStyle: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          enabled: true,
        ),
      ),
    );
  }
}

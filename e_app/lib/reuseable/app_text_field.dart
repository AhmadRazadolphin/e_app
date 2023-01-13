import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? firstValue;
  const AppTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.suffixIcon,
    this.textInputType,
    this.prefixIcon,
    this.firstValue,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        // height: 60,
        child: TextFormField(
          initialValue: firstValue,
          controller: controller,
          cursorColor: Colors.black,
          keyboardType: textInputType,
          validator: (value) {
            if (value!.isEmpty) {
              return labelText;
            }
            return null;
          },
          decoration: InputDecoration(
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              labelText: labelText,
              hintText: hintText,
              labelStyle: const TextStyle(color: Colors.blue),
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFFEFF0F7),
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(12),
              //   borderSide: const BorderSide(width: 1.0, color: Colors.white),
              // ),
              // disabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(12),
              //   borderSide: const BorderSide(width: 1.0, color: Colors.black),
              // ),
              // errorBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(12),
              //   borderSide: const BorderSide(width: 1.0, color: Colors.yellow),
              // ),
              // focusedErrorBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(12),
              //   borderSide: const BorderSide(width: 1.0, color: Colors.green),
              // ),
              // focusedBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(12),
              //   borderSide: const BorderSide(width: 1.0, color: Colors.grey),
              // ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(width: 1.0, color: Colors.blue),
              )),
        ),
      ),
    );
  }
}

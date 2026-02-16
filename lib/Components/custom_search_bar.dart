import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String prefixIconPath;

  const CustomSearchBar({
    super.key,
    required this.hintText,
    this.keyboardType,
    required this.controller,
    required this.prefixIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Color(0xFFF2F2F3),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(15),
          child: Image.asset(prefixIconPath, width: 17, height: 17),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

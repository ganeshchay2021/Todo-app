// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String textTitle;
  final int? maxLine;
  final TextEditingController controller;
  const MyTextField({
    super.key,
    required this.textTitle,
    required this.maxLine,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLine,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        border: InputBorder.none,
        hintText: textTitle,
      ),
    );
  }
}

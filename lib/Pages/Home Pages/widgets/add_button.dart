// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todoapp/TextStyle/my_text_style.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
        onPressed: onPressed,
        child: Text(
          "New Task",
          style: myTextStyle(color: Colors.white, fontweight: FontWeight.bold),
        ),
      ),
    );
  }
}

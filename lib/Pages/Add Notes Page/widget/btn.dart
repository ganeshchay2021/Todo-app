// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:todoapp/TextStyle/my_text_style.dart';

class Btn extends StatelessWidget {
  final VoidCallback onPressed;
  final String btnTitle;

  const Btn({
    super.key,
    required this.onPressed,
    required this.btnTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 50,
      width: MediaQuery.of(context).size.width * 0.35,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
        onPressed: onPressed,
        child: Text(
          btnTitle,
          style: myTextStyle(color: Colors.white, fontweight: FontWeight.bold),
        ),
      ),
    );
  }
}

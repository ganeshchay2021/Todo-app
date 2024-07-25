import 'package:flutter/material.dart';
import 'package:todoapp/TextStyle/my_text_style.dart';

AppBar myAppBar({String? pageTitle, bool showBtn = false}) {
  return AppBar(
    leading: showBtn
        ? const BackButton(
            color: Colors.white,
          )
        : null,
    centerTitle: true,
    backgroundColor: Colors.indigo,
    title: Text(
      "$pageTitle",
      style: myTextStyle(
          size: 20, fontweight: FontWeight.bold, color: Colors.white),
    ),
  );
}

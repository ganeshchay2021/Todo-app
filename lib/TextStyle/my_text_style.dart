import 'package:flutter/material.dart';

TextStyle myTextStyle(
    {double? size, Color? color, FontWeight fontweight = FontWeight.normal}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: fontweight,
  );
}

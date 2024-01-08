import 'package:flutter/material.dart';

Color primColor = const Color(0xFF0000F3);
Color secColor = const Color(0xFFF5F5F5);

TextStyle stylish(double size, Color color){
  TextStyle style = TextStyle(
    fontSize: size,
    fontWeight: FontWeight.bold,
    color: color,
  );
  return style;
}
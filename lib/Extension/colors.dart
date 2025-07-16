import 'package:flutter/material.dart';

class AppColors {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static const Color primaryColor = Color(0xFF17B0CF);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color redColor = Color(0xFFE70000);
  static const Color successColor = Color(0xFF069016);
}
import 'package:flutter/material.dart';

extension CustomFont on TextStyle {
  TextStyle light({double fontSize = 14.0}) =>
      copyWith(fontWeight: FontWeight.w300, fontSize: fontSize);
  TextStyle regular({double fontSize = 14.0}) =>
      copyWith(fontWeight: FontWeight.w400, fontSize: fontSize);
  TextStyle medium({double fontSize = 14.0}) =>
      copyWith(fontWeight: FontWeight.w500, fontSize: fontSize);
  TextStyle semibold({double fontSize = 14.0}) =>
      copyWith(fontWeight: FontWeight.w600, fontSize: fontSize);
  TextStyle bold({double fontSize = 14.0}) =>
      copyWith(fontWeight: FontWeight.w700, fontSize: fontSize);
}

extension StringPascalCaseExtension on String {
  String toPascalCaseWithSpaces() {
    return split('_')
        .map((word) =>
            word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : '')
        .join(' ');
  }
}



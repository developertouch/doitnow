import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle HEADING_TEXT = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Color(0xff595252).withOpacity(0.9)
  );
  static TextStyle DESCRIPTION_TEXT = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: Color(0xff000000).withOpacity(0.5)
  );
  static TextStyle BUTTON_TEXT = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle DATA_LIST_HEADING = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.black,
  );
  static TextStyle DATA_LIST_DESCRIPTION = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
}
import 'package:flutter/material.dart';

import '../constants.dart';

Widget title(String text) {
  return Text(text, style: TextStyle(fontSize: titleFontSize, color: titleColor, fontWeight: FontWeight.bold) ,);
}
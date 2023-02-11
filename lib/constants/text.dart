import 'package:flutter/material.dart';

import 'color.dart';

TextStyle customTextStyle({
  double fontsize = 16.0,
  Color color = Colors.transparent,
  FontWeight fontWeight = FontWeight.normal,
}) =>
    TextStyle(
      fontSize: fontsize,
      color: color,
      fontWeight: fontWeight,
    );

TextStyle titleTextStyle() {
  return customTextStyle(
    color: ColorUtility().white,
    fontsize: 20,
    fontWeight: FontWeight.w800,
  );
}

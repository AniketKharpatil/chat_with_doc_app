import 'package:flutter/material.dart';

BoxShadow kCardShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.5),
  spreadRadius: 5,
  blurRadius: 7,
  offset: Offset(0, 3), // changes position of shadow
);

TextStyle kHeadTextStyle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 17,
);
TextStyle kSubHeadTextStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 17,
);

import 'package:flutter/material.dart';
import 'package:rich_advert_app/constants.dart';

var kThemeData = ThemeData(
  primarySwatch: Colors.yellow,
  accentColor: kOrangeColor,
  buttonColor: kGreyColor,
  fontFamily: "Roboto",
  textTheme: TextTheme(
    headline1: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        fontSize: 20,
        color: Colors.black),
    headline2: TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    subtitle1: TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    bodyText1: TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    bodyText2: TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    caption: TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
  ),
);

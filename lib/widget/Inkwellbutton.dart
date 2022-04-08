import 'package:flutter/material.dart';

defaultinkwellbutton({
  String? text,
  Color? textcolor,
  double? fontsize,
  required void Function() ontap,
}) =>
    InkWell(
      onTap: ontap,
      child: Text(
        text!,
        style: TextStyle(
            color: textcolor, fontWeight: FontWeight.bold, fontSize: fontsize),
      ),
    );

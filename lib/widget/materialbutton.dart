import 'dart:ffi';

import 'package:flutter/material.dart';

defaultbutton(
        {Color? background,
        Color? splashcolor,
        Color? textcolor,
        double? minwidth,
        String? text,
        required Function()? function()}) =>
    MaterialButton(
      height: 50,
      minWidth: minwidth,
      onPressed: function,
      animationDuration: const Duration(milliseconds: 500),
      splashColor: splashcolor,
      color: background,
      child: Text(
        text!,
        style: TextStyle(color: textcolor, fontSize: 23),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    );

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget defaulttextformfilder(
        {String? hinttext,
        Icon? prefixicon,
        bool obscuretext = false,
        String? label1,
        required String? Function(String?) val,
        void Function(String?)? onsaved,
        void Function(String)? onchanged,
        TextInputType? type,
        String? initialvalue}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.yellow[500],
      ),
      child: TextFormField(
        keyboardType: type,
        obscureText: obscuretext,
        decoration: InputDecoration(
          label: Text('${label1}'),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(32.0)),
          hintText: hinttext,
          prefixIcon: prefixicon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        validator: val,
        initialValue: initialvalue,
        onSaved: onsaved,
        onChanged: onchanged,
      ),
    );

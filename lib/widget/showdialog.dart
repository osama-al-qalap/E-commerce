import 'package:flutter/material.dart';

progressDialogue(BuildContext context) {
  //set up the AlertDialog

  return showDialog(
    //prevent outside touch
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      //prevent Back button press
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}

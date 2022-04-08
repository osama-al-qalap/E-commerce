// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'dart:math';

import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class add_image extends ChangeNotifier {
  bool isgallery = true;
  var file, nameimage1;
  addimagesprovider(BuildContext context, bool value) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = value == true
        ? await _picker.pickImage(source: ImageSource.gallery)
        : await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      file = File(image.path);
      var nameimage = basename(image.path);
      var random = Random().nextInt(1000000);
      nameimage1 = '$nameimage$random';

      Navigator.of(context).pop();
    }
  }

  @override
  notifyListeners();
}

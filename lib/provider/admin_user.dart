import 'package:flutter/material.dart';
import 'package:flutter_ecomme_1/screen/auth/login.dart';

class admin_user extends ChangeNotifier {
  bool isadmin = false;

  chandegeisadmin(bool value) {
    isadmin = value;

    notifyListeners();
  }
}

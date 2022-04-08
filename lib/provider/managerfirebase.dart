import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecomme_1/constant/const.dart';

class managerfirebase extends ChangeNotifier {
  delateimage(resultmanagerprodect) async {
    try {
      await FirebaseFirestore.instance
          .collection(kProductsCollection)
          .doc()
          .delete();
      await FirebaseStorage.instance
          .refFromURL(resultmanagerprodect[kProductLocation])
          .delete();
    } catch (e) {}
    notifyListeners();
  }
}

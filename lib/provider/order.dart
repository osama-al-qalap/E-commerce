import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderItem {
  //final String id;

  final String address;
  final DateTime dateTime;
  final int quntitle;
  Map<String, dynamic> cart;
  OrderItem({
    required this.address,
    required this.dateTime,
    required this.quntitle,
    required this.cart,
  });
}

class orderh with ChangeNotifier {
  double totallprice = 0;
  Map<String, dynamic> cartorder = {};
  Future<void> addorder(String address) async {
    await FirebaseFirestore.instance.collection('kOrderDetails').add({
      'dateTime': DateTime.now(),
      'address': address,
      'cart': cartorder,
      'totallprice': totallprice,
      'uid': FirebaseAuth.instance.currentUser!.uid,
    });
    totallprice = 0;
    notifyListeners();
  }

  Future<void> delateorder(String id) async {
    await FirebaseFirestore.instance.collection('CART').doc(id).delete();
  }
}

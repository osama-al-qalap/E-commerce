import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecomme_1/constant/const.dart';

class CartItem {
  //final String id;
  final String name;
  final double prise;
  final int quntitle;
  final String imageitem;
  final String uid1;
  CartItem({
    required this.name,
    required this.prise,
    required this.quntitle,
    required this.imageitem,
    required this.uid1,
  });
}

class cardh with ChangeNotifier {
  Map<String, CartItem> _items = {};
  int quntitle = 1;

  Map<String, CartItem> get item {
    return {..._items};
  }

  int get itemcount {
    return _items.length;
  }

  int get itemquntitle {
    return quntitle;
  }

  addquntitle() {
    quntitle++;
    notifyListeners();
  }

  deletequntitle() {
    if (quntitle <= 1) {
      quntitle = 1;
    } else {
      quntitle--;
    }
    notifyListeners();
  }

  double get totalamount {
    var total = 0.0;
    /*FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart");*/
    _items.forEach((key, CartItem) {
      total += CartItem.prise * CartItem.quntitle;
    });
    return total;
  }

  void additem(
    String name,
    double pries,
    String title,
    String imageitem,
    String uid1,
  ) async {
    /*if (_items.containsKey(name)) {
      _items.update(
        name,
        (value) => CartItem(
            imageitem: value.imageitem,
            name: value.name,
            prise: value.prise,
            quntitle: value.quntitle + 1,
            uid1: FirebaseAuth.instance.currentUser!.uid),
      );*/
    await FirebaseFirestore.instance.collection('CART').doc().set({
      kProductLocation: imageitem,
      kProductPrice: pries,
      kProductName: name,
      'quntitle': quntitle,
      'uid': FirebaseAuth.instance.currentUser!.uid,
    });
    quntitle = 1;
    /*}else {
      _items.putIfAbsent(
          name,
          () => CartItem(
              imageitem: imageitem,
              name: name,
              prise: pries,
              quntitle: quntitle,
              uid1: FirebaseAuth.instance.currentUser!.uid));
      await FirebaseFirestore.instance
          .collection("CART")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        kProductLocation: imageitem,
        kProductPrice: pries,
        kProductName: name,
        'quntitle': quntitle,
        'uid': FirebaseAuth.instance.currentUser!.uid,
      });
      quntitle = 1;
    }*/
    notifyListeners();
  }

  void removeitem(String name) {
    _items.remove(name);
    notifyListeners();
  }

  void removesingleitem(String name) {
    if (!_items.containsKey(name)) {
      return;
    } else {
      if (_items[name]!.quntitle > 1) {
        _items.update(
            name,
            (value) => CartItem(
                imageitem: value.imageitem,
                name: value.name,
                prise: value.prise,
                quntitle: value.quntitle - 1,
                uid1: FirebaseAuth.instance.currentUser!.uid));
      } else {
        _items.remove(name);
      }
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}

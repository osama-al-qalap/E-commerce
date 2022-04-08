import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_ecomme_1/model/prodect_model.dart';
import 'package:flutter_ecomme_1/constant/const.dart';

class store {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  add_prodect(Product product) async {
    await _firestore.collection(kProductsCollection).add({
      kProductName: product.pname,
      kProductPrice: product.pprice,
      kProductCategory: product.pcategory,
      kProductDescription: product.pdescription,
      kProductLocation: product.plocation,
    });
  }

  update_prodect(Product product) async {
    await _firestore.collection(kProductsCollection).doc().update({
      kProductName: product.pname,
      kProductPrice: product.pprice,
      kProductCategory: product.pcategory,
      kProductDescription: product.pdescription,
      kProductLocation: product.plocation,
    }).catchError((e) {
      print(e);
    });
  }

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _firestore
        .collection(kOrders)
        .doc(documentId)
        .collection(kOrderDetails)
        .snapshots();
  }

  storeOrders(data, List<Product> products) {
    var documentRef = _firestore.collection(kOrders).doc();
    documentRef.set(data);
    for (var product in products) {
      documentRef.collection(kOrderDetails).doc().set({
        kProductName: product.pname,
        kProductPrice: product.pprice,
        kProductQuantity: product.pdescription,
        kProductLocation: product.plocation,
        kProductCategory: product.pcategory
      });
    }
  }
}

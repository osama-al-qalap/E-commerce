import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecomme_1/constant/const.dart';
import 'package:flutter_ecomme_1/model/prodect_model.dart';

class Order {
  String? documentId;
  int? totallPrice;
  String? address;
  Order(
      {required this.totallPrice,
      required this.address,
      required this.documentId});
  storeOrders(data, List<Order> order) {
    var documentRef = FirebaseFirestore.instance.collection('Orders').doc();
    documentRef.set(data);
    for (var order in order) {
      documentRef.collection(kOrderDetails).doc().set({});
    }
  }
}

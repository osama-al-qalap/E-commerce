import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecomme_1/constant/const.dart';
import 'package:flutter_ecomme_1/model/store.dart';
import 'package:flutter_ecomme_1/provider/order.dart';
import 'package:flutter_ecomme_1/widget/materialbutton.dart';
import 'package:provider/provider.dart';

import '../../model/prodect_model.dart';

class OrderDetails extends StatelessWidget {
  final result_uid;
  OrderDetails({Key? key, this.result_uid}) : super(key: key);
  final store _store = store();

  var id;
  @override
  Widget build(BuildContext context) {
    Object? documentId = ModalRoute.of(context)!.settings.arguments;
    var order1 = Provider.of<orderh>(context, listen: false);
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('CART')
              .where('uid', isEqualTo: result_uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if (snapshot.hasError) {
              return Text('Error');
            }

            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var result = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        id = snapshot.data!.docs[index].id;
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .2,
                            color: kSecondaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('product name : ${result[kProductName]}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Quantity : ${result['quntitle']}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Product price : ${result[kProductPrice]}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: ButtonTheme(
                          buttonColor: kmaincolor,
                          child: defaultbutton(
                              function: () {}, text: 'Confirm Order'),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ButtonTheme(
                          buttonColor: kmaincolor,
                          child: defaultbutton(
                              function: () {
                                order1.delateorder(id);
                              },
                              text: 'Delete Order'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

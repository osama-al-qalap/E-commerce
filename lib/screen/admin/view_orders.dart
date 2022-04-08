import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecomme_1/constant/const.dart';
import 'package:flutter_ecomme_1/screen/admin/OrderDetails.dart';
import 'package:flutter_ecomme_1/screen/admin/edit_product.dart';
import 'package:flutter_ecomme_1/screen/admin/manage_prodect.dart';
import 'package:provider/provider.dart';
import '../../model/order.dart';
import '../../model/store.dart';
import '../../provider/auth/auth_provider.dart';
import '../../provider/managerfirebase.dart';

class View_orders extends StatefulWidget {
  View_orders({Key? key}) : super(key: key);

  @override
  State<View_orders> createState() => _View_ordersState();
}

class _View_ordersState extends State<View_orders> {
  final store _store = store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('kOrderDetails')
              .get()
              .asStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if (snapshot.hasError) {
              return Text('Error');
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var resultmanagerprodect =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  var doucid = snapshot.data!.docs[index].id;
                  var result_uid = resultmanagerprodect['uid'];
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OrderDetails(result_uid: result_uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .2,
                        color: kSecondaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  'Totall Price = \$${resultmanagerprodect['totallprice']}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Address is ${resultmanagerprodect['address']}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Time is ${resultmanagerprodect['dateTime'].hour.toString() + ":" + resultmanagerprodect['dateTime'].minute.toString() + ":" + resultmanagerprodect['dateTime'].second.toString()}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecomme_1/provider/managerfirebase.dart';
import 'package:flutter_ecomme_1/screen/admin/edit_product.dart';
import 'package:flutter_ecomme_1/widget/showdialog.dart';
import 'package:flutter_ecomme_1/model/store.dart';
import 'package:provider/provider.dart';
import '../../constant/const.dart';
import '../../model/prodect_model.dart';

import 'package:cached_network_image/cached_network_image.dart';

class manage_product extends StatefulWidget {
  const manage_product({
    Key? key,
  }) : super(key: key);

  @override
  State<manage_product> createState() => _manage_productState();
}

class _manage_productState extends State<manage_product> {
  List<Product> _product = [];
  final _store = store();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Manage Prodect'),
          backgroundColor: kmaincolor,
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(kProductsCollection)
                .get()
                .asStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              if (snapshot.hasError) {
                return Text('Error');
              }
              return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.8),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, indexedit) {
                    var resultmanagerprodect = snapshot.data!.docs[indexedit]
                        .data() as Map<String, dynamic>;
                    var doucid = snapshot.data!.docs[indexedit].id;
                    var managerfirebase1 =
                        Provider.of<managerfirebase>(context, listen: false);

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => edit_product(
                                    resultmanagerprodect: resultmanagerprodect,
                                    doucid: doucid)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl:
                                        resultmanagerprodect[kProductLocation],
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error))),
                            Positioned(
                              bottom: 0,
                              child: Opacity(
                                opacity: 0.6,
                                child: Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              left: 1,
                              child: Column(
                                children: [
                                  Text(
                                    '${resultmanagerprodect[kProductName]}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '\$ ${resultmanagerprodect[kProductCategory]}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }));
  }
}

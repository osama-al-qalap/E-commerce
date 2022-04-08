import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecomme_1/constant/const.dart';
import 'package:flutter_ecomme_1/provider/auth/auth_provider.dart';
import 'package:flutter_ecomme_1/provider/card.dart';
import 'package:flutter_ecomme_1/provider/order.dart';

import 'package:flutter_ecomme_1/screen/user/homePage.dart';
import 'package:flutter_ecomme_1/widget/textfornfilder.dart';

import 'package:provider/provider.dart';

import '../../model/prodect_model.dart';
import '../../model/user_model.dart';

class cartscreen extends StatefulWidget {
  cartscreen({Key? key}) : super(key: key);

  @override
  State<cartscreen> createState() => _cartscreenState();
}

class _cartscreenState extends State<cartscreen> {
  String? address;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var card1 = Provider.of<cardh>(context, listen: false);
    var order1 = Provider.of<orderh>(context, listen: false);
    var authprovider = Provider.of<auth_provider>(context, listen: false);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('CART'),
        backgroundColor: kmaincolor,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => homepageuser(),
                  ));
            }),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('CART')
                      .get()
                      .asStream(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    if (snapshot.hasError) {
                      return Text('Error');
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var resultmanagerprodect = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        var doucid = snapshot.data!.docs[index].id;
                        resultmanagerprodect[kProductPrice] == null
                            ? 0
                            : order1.totallprice +=
                                resultmanagerprodect[kProductPrice]! *
                                    resultmanagerprodect['quntitle'];
                        order1.cartorder = {
                          kProductName: resultmanagerprodect[kProductName],
                          kProductPrice: resultmanagerprodect[kProductPrice],
                          'quntitle': resultmanagerprodect['quntitle'],
                        };
                        return Dismissible(
                          onDismissed: (value) async {
                            await FirebaseFirestore.instance
                                .collection('CART')
                                .doc(doucid)
                                .delete();
                          },
                          key: UniqueKey(),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              height: screenHeight * .15,
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: screenHeight * .15 / 2,
                                    backgroundImage: NetworkImage(
                                        '${resultmanagerprodect[kProductLocation]}'),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                '${resultmanagerprodect[kProductName]}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '\$ ${resultmanagerprodect[kProductPrice]}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            '${resultmanagerprodect['quntitle']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              color: kSecondaryColor,
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                    color: kmaincolor,
                    border: Border.all(width: 3.0)),
                child: InkWell(
                    child: Text(
                      'cart'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                    onTap: () async {
                      AlertDialog alertDialog = AlertDialog(
                        actions: <Widget>[
                          MaterialButton(
                              onPressed: () {
                                _formKey.currentState!.save();
                                Navigator.of(context).pop();

                                order1.addorder('address');
                              },
                              child: Text('Confirm'))
                        ],
                        content: defaulttextformfilder(
                            label1: 'Enter your Address',
                            hinttext: 'Enter your Address',
                            onsaved: (value) {
                              address = value;
                            },
                            val: (value) {
                              if (value!.isEmpty || value == null) return '';
                            }),
                        title: Text(
                            'Totall Price  = \$ ${Provider.of<orderh>(context, listen: false).totallprice}'),
                      );
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return alertDialog;
                          });
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

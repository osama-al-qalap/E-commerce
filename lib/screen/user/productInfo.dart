import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecomme_1/constant/const.dart';
import 'package:flutter_ecomme_1/model/prodect_model.dart';
import 'package:flutter_ecomme_1/provider/card.dart';
import 'package:flutter_ecomme_1/screen/auth/login.dart';

import 'package:flutter_ecomme_1/screen/user/homePage.dart';

import 'package:provider/provider.dart';

import 'CartScreen.dart';

class ProductInfo extends StatefulWidget {
  final resultmanagerprodect;
  final doucid;
  final indexedit;
  final uid1;
  ProductInfo(
      {Key? key,
      this.uid1,
      this.indexedit,
      this.resultmanagerprodect,
      this.doucid})
      : super(key: key);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    Object? product = ModalRoute.of(context)!.settings.arguments;
    var card1 = Provider.of<cardh>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
                '${widget.resultmanagerprodect[kProductLocation]}'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cartscreen()));
                      },
                      child: Icon(Icons.shopping_cart))
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: <Widget>[
                Opacity(
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .3,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.resultmanagerprodect[kProductName],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.resultmanagerprodect[kProductDescription],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '\$${widget.resultmanagerprodect[kProductPrice]}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipOval(
                                child: Material(
                                  color: kmaincolor,
                                  child: GestureDetector(
                                    onTap: () {
                                      card1.addquntitle();
                                    },
                                    child: SizedBox(
                                      child: Icon(Icons.add),
                                      height: 32,
                                      width: 32,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                Provider.of<cardh>(context).quntitle.toString(),
                                style: TextStyle(fontSize: 60),
                              ),
                              ClipOval(
                                child: Material(
                                  color: kmaincolor,
                                  child: GestureDetector(
                                    onTap: () {
                                      card1.deletequntitle();
                                    },
                                    child: SizedBox(
                                      child: Icon(Icons.remove),
                                      height: 32,
                                      width: 32,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  opacity: .5,
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .08,
                  child: Builder(
                    builder: (context) => RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10))),
                      color: kmaincolor,
                      onPressed: () {
                        card1.additem(
                            widget.resultmanagerprodect[kProductName],
                            widget.resultmanagerprodect[kProductPrice],
                            widget.resultmanagerprodect[kProductDescription],
                            widget.resultmanagerprodect[kProductLocation],
                            FirebaseAuth.instance.currentUser!.uid);

                        print(widget.resultmanagerprodect[kProductPrice]);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => homepageuser()));
                      },
                      child: Text(
                        'Add to Cart'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

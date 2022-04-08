import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecomme_1/constant/const.dart';
import 'package:flutter_ecomme_1/screen/auth/login.dart';
import 'package:flutter_ecomme_1/screen/user/CartScreen.dart';
import 'package:flutter_ecomme_1/screen/user/productInfo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/auth/auth_provider.dart';

class homepageuser extends StatelessWidget {
  homepageuser({Key? key}) : super(key: key);

  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;

  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<auth_provider>(context, listen: false);
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: kUnActiveColor,
              currentIndex: _bottomBarIndex,
              fixedColor: kmaincolor,
              onTap: (value) async {
                if (value == 2) {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.clear();
                  await authprovider.Logout_method(context);
                }
              },
              items: [
                BottomNavigationBarItem(
                    label: 'Test', icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    label: 'Test', icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    label: 'Sign Out', icon: Icon(Icons.close)),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: kmaincolor,
                onTap: (value) {},
                tabs: [
                  Text(
                    'Jackets',
                    style: TextStyle(
                      color: _tabBarIndex == 0 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 0 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Trouser',
                    style: TextStyle(
                      color: _tabBarIndex == 1 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 1 ? 16 : null,
                    ),
                  ),
                  Text(
                    'T-shirts',
                    style: TextStyle(
                      color: _tabBarIndex == 2 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 2 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Shoes',
                    style: TextStyle(
                      color: _tabBarIndex == 3 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 3 ? 16 : null,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                jacketView(),
                Text('data'),
                Text('data'),
                Text('data'),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cartscreen()));
                      },
                      child: Icon(Icons.shopping_cart))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget jacketView() {
    return FutureBuilder<QuerySnapshot>(
        future:
            FirebaseFirestore.instance.collection(kProductsCollection).get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          var uid1 = FirebaseAuth.instance.currentUser!.uid;
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError) {
            return Text('Error');
          }
          return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) {
                var resultmanagerprodect =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                var doucid = snapshot.data!.docs[index].id;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductInfo(
                                    resultmanagerprodect: resultmanagerprodect,
                                    doucid: doucid,
                                  )));
                    },
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: CachedNetworkImage(
                              imageUrl: resultmanagerprodect[kProductLocation],
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error)),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Opacity(
                            opacity: .6,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      resultmanagerprodect[kProductName],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        '\$ ${resultmanagerprodect[kProductPrice]}')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 1,
                          bottom: 2,
                          child: IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('Cart')
                                  .add({
                                kProductName:
                                    resultmanagerprodect[kProductName],
                                kProductQuantity:
                                    resultmanagerprodect[kProductQuantity],
                                kProductPrice:
                                    resultmanagerprodect[kProductPrice],
                                kProductCategory:
                                    resultmanagerprodect[kProductCategory],
                                kProductLocation:
                                    resultmanagerprodect[kProductLocation],
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}

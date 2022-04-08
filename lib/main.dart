import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecomme_1/provider/add_image.dart';
import 'package:flutter_ecomme_1/provider/admin_user.dart';
import 'package:flutter_ecomme_1/provider/auth/auth_provider.dart';
import 'package:flutter_ecomme_1/provider/card.dart';

import 'package:flutter_ecomme_1/provider/managerfirebase.dart';
import 'package:flutter_ecomme_1/provider/order.dart';
import 'package:flutter_ecomme_1/screen/admin/manage_prodect.dart';
import 'package:flutter_ecomme_1/screen/admin/view_orders.dart';
import 'package:flutter_ecomme_1/screen/auth/login.dart';
import 'package:flutter_ecomme_1/screen/admin/home_admin.dart';

import 'package:flutter_ecomme_1/screen/user/homePage.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final auth_provider auth = auth_provider();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<auth_provider>(create: (context) => auth_provider()),
    ChangeNotifierProvider<admin_user>(create: (context) => admin_user()),
    ChangeNotifierProvider<add_image>(create: (context) => add_image()),
    ChangeNotifierProvider<cardh>(create: (context) => cardh()),
    ChangeNotifierProvider<orderh>(create: (context) => orderh()),
    ChangeNotifierProvider<managerfirebase>(
        create: (context) => managerfirebase()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<auth_provider>(context, listen: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: authprovider.check_auth(),
    );
  }
}

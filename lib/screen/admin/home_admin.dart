import 'package:flutter/material.dart';
import 'package:flutter_ecomme_1/screen/admin/add_product.dart';
import 'package:flutter_ecomme_1/constant/const.dart';
import 'package:flutter_ecomme_1/screen/admin/manage_prodect.dart';
import 'package:flutter_ecomme_1/screen/admin/view_orders.dart';
import '../../widget/showdialog.dart';
import '../../widget/materialbutton.dart';

class home_admin extends StatelessWidget {
  const home_admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kmaincolor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              defaultbutton(
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => add_prodect()));
                  },
                  text: 'Add Product',
                  background: Color.fromARGB(174, 211, 192, 25),
                  splashcolor: Colors.yellow[600],
                  minwidth: 200),
              const SizedBox(
                height: 25,
              ),
              defaultbutton(
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => manage_product()));
                  },
                  text: 'Edite prodect',
                  background: Color.fromARGB(174, 211, 192, 25),
                  splashcolor: Colors.yellow[600],
                  minwidth: 200),
              const SizedBox(
                height: 25,
              ),
              defaultbutton(
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => View_orders()));
                  },
                  text: 'View orders',
                  background: Color.fromARGB(174, 211, 192, 25),
                  splashcolor: Color.fromARGB(255, 184, 153, 17),
                  minwidth: 200),
            ]),
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_ecomme_1/constant/const.dart';
import 'package:flutter_ecomme_1/provider/add_image.dart';
import 'package:flutter_ecomme_1/provider/managerfirebase.dart';
import 'package:flutter_ecomme_1/screen/admin/home_admin.dart';
import 'package:flutter_ecomme_1/screen/admin/manage_prodect.dart';
import 'package:flutter_ecomme_1/widget/showmodalbottom.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecomme_1/model/store.dart';
import 'package:provider/provider.dart';
import '../../widget/showdialog.dart';
import '../../model/prodect_model.dart';
import '../../widget/textfornfilder.dart';

class edit_product extends StatelessWidget {
  final indexedit;

  final resultmanagerprodect;
  final doucid;

  edit_product(
      {Key? key, this.indexedit, this.resultmanagerprodect, this.doucid})
      : super(key: key);

  var refstorge;
  String? _name, _description, _category, _imagelocation;
  double _price = 0;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var managerfirebase1 = Provider.of<managerfirebase>(context, listen: false);
    var addimage = Provider.of<add_image>(context, listen: false);
    double mqw = MediaQuery.of(context).size.width;
    double mqh = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: [
              SizedBox(
                height: 75,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: mqh * 0.30,
                  width: mqw / 2,
                  child: CachedNetworkImage(
                      imageUrl: resultmanagerprodect[kProductLocation],
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                      errorWidget: (context, url, error) => Icon(Icons.error)),
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 10,
              ),
              defaulttextformfilder(
                  val: (value) {
                    if (value == null || value.isEmpty) return '';
                  },
                  onsaved: (value) {
                    _name = value;
                  },
                  label1: 'Product Name',
                  initialvalue: resultmanagerprodect[kProductName],
                  hinttext: 'Product Name'),
              SizedBox(
                height: 20,
              ),
              defaulttextformfilder(
                  type: TextInputType.number,
                  val: (value) {
                    if (value == null || value.isEmpty) return '';
                  },
                  label1: 'Product Price',
                  initialvalue: resultmanagerprodect[kProductPrice].toString(),
                  onsaved: (value) {
                    _price = double.tryParse(value!) ?? 0;
                  },
                  hinttext: 'Product Price'),
              SizedBox(
                height: 20,
              ),
              defaulttextformfilder(
                  val: (value) {
                    if (value == null || value.isEmpty) return '';
                  },
                  label1: 'Product Description',
                  initialvalue: resultmanagerprodect[kProductDescription],
                  onsaved: (value) {
                    _description = value;
                  },
                  hinttext: 'Product Description'),
              SizedBox(
                height: 20,
              ),
              defaulttextformfilder(
                  val: (value) {
                    if (value == null || value.isEmpty) return '';
                  },
                  label1: 'Prodect Category',
                  initialvalue: resultmanagerprodect[kProductCategory],
                  onsaved: (value) {
                    _category = value;
                  },
                  hinttext: 'Prodect Category'),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                height: 50,
                minWidth: 200,
                onPressed: () async {
                  await showmodalmottomsheet(context);
                },
                animationDuration: Duration(milliseconds: 500),
                splashColor: Colors.yellow[600],
                color: Colors.yellow[400],
                child: Text(
                  'Edit Image',
                  style: TextStyle(color: Colors.black, fontSize: 23),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                height: 50,
                minWidth: 200,
                onPressed: () async {
                  progressDialogue(context);
                  var fromdata = _formKey.currentState;
                  if (fromdata!.validate() == true) {
                    fromdata.save();
                    if (addimage.file == null) {
                      await FirebaseFirestore.instance
                          .collection(kProductsCollection)
                          .doc(doucid)
                          .update({
                        'productName': _name,
                        'prodectPrice': _price,
                        'productDescription': _description,
                        'productCategory': _category,
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => manage_product()));
                    } else {
                      refstorge = FirebaseStorage.instance
                          .ref('image')
                          .child(addimage.nameimage1);

                      await refstorge.putFile(addimage.file);

                      _imagelocation = await refstorge.getDownloadURL();

                      FirebaseFirestore.instance
                          .collection(kProductsCollection)
                          .doc(doucid)
                          .update({
                        'productName': _name,
                        'prodectPrice': _price,
                        'productDescription': _description,
                        'productCategory': _category,
                        'productLocation': _imagelocation,
                      });

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => manage_product()));
                    }
                  }
                },
                animationDuration: Duration(milliseconds: 500),
                splashColor: Colors.yellow[600],
                color: Colors.yellow[400],
                child: Text(
                  'Edit Product',
                  style: TextStyle(color: Colors.black, fontSize: 23),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                height: 50,
                minWidth: 200,
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection(kProductsCollection)
                      .doc(doucid)
                      .delete();
                  await FirebaseStorage.instance
                      .refFromURL(resultmanagerprodect[kProductLocation])
                      .delete();

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => manage_product()));
                },
                animationDuration: Duration(milliseconds: 500),
                splashColor: Colors.yellow[600],
                color: Colors.yellow[400],
                child: Text(
                  'delete',
                  style: TextStyle(color: Colors.black, fontSize: 23),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

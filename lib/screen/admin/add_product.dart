import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecomme_1/constant/const.dart';
import 'package:flutter_ecomme_1/provider/add_image.dart';
import 'package:flutter_ecomme_1/screen/admin/home_admin.dart';
import 'package:flutter_ecomme_1/widget/showmodalbottom.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecomme_1/model/store.dart';
import 'package:provider/provider.dart';
import '../../widget/showdialog.dart';
import '../../model/prodect_model.dart';
import '../../widget/textfornfilder.dart';

class add_prodect extends StatelessWidget {
  add_prodect({Key? key}) : super(key: key);
  var refstorge;
  String? _name, _description, _category, _imagelocation;
  double? _price;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var addimage = Provider.of<add_image>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kmaincolor,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: [
              SizedBox(
                height: 75,
              ),
              defaulttextformfilder(
                  val: (value) {
                    if (value == null || value.isEmpty) return '';
                  },
                  onsaved: (value) {
                    _name = value;
                  },
                  label1: 'Product Name',
                  hinttext: 'Product Name'),
              SizedBox(
                height: 20,
              ),
              defaulttextformfilder(
                  type: TextInputType.number,
                  val: (value) {
                    if (value == null || value.isEmpty) return '';
                  },
                  onsaved: (value) {
                    _price = double.tryParse(value!) ?? 0;
                  },
                  label1: 'Product Price',
                  hinttext: 'Product Price'),
              SizedBox(
                height: 20,
              ),
              defaulttextformfilder(
                  val: (value) {
                    if (value == null || value.isEmpty) return '';
                  },
                  onsaved: (value) {
                    _description = value;
                  },
                  label1: 'Product Description',
                  hinttext: 'Product Description'),
              SizedBox(
                height: 20,
              ),
              defaulttextformfilder(
                  val: (value) {
                    if (value == null || value.isEmpty) return '';
                  },
                  onsaved: (value) {
                    _category = value;
                  },
                  label1: 'Prodect Category',
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
                  'Add Image',
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
                  progressDialogue(context);
                  if (addimage.file != null) {
                    var fromdata = _formKey.currentState;
                    if (fromdata!.validate() == true) {
                      fromdata.save();

                      refstorge = FirebaseStorage.instance
                          .ref('image')
                          .child(addimage.nameimage1);
                      await refstorge.putFile(addimage.file);

                      _imagelocation = await refstorge.getDownloadURL();

                      FirebaseFirestore.instance
                          .collection(kProductsCollection)
                          .add({
                        kProductCategory: _category,
                        kProductName: _name,
                        kProductPrice: _price,
                        kProductDescription: _description,
                        kProductLocation: _imagelocation,
                      });

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => home_admin()));
                    }
                  } else {
                    AwesomeDialog(
                        context: context,
                        title: 'worng',
                        body: Text('add image'))
                      ..show();
                  }
                },
                animationDuration: Duration(milliseconds: 500),
                splashColor: Colors.yellow[600],
                color: Colors.yellow[400],
                child: Text(
                  'Add Product',
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

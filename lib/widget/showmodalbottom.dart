import 'package:flutter/material.dart';
import 'package:flutter_ecomme_1/provider/add_image.dart';

import 'package:provider/provider.dart';

showmodalmottomsheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        var addimage = Provider.of<add_image>(context, listen: false);
        return Container(
            height: 160,
            color: Colors.blue[100],
            child: Column(
              children: [
                const SizedBox(
                  height: 9,
                ),
                MaterialButton(
                    height: 50,
                    minWidth: 200,
                    animationDuration: const Duration(milliseconds: 500),
                    splashColor: Colors.yellow[600],
                    color: Colors.yellow[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    onPressed: () async {
                      addimage.addimagesprovider(context, true);
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Gallery',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 23)),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.picture_in_picture_outlined)
                        ])),
                const SizedBox(
                  height: 12,
                ),
                MaterialButton(
                    height: 50,
                    minWidth: 200,
                    animationDuration: const Duration(milliseconds: 500),
                    splashColor: Colors.yellow[600],
                    color: Colors.yellow[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    onPressed: () async {
                      addimage.addimagesprovider(context, false);
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Camera',
                            style: TextStyle(color: Colors.black, fontSize: 23),
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Icon(Icons.camera)
                        ])),
              ],
            ));
      });
}

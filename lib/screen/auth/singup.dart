import 'package:flutter/material.dart';
import 'package:flutter_ecomme_1/provider/auth/auth_provider.dart';
import 'package:flutter_ecomme_1/constant/const.dart';
import 'package:flutter_ecomme_1/screen/auth/login.dart';
import 'package:flutter_ecomme_1/widget/Inkwellbutton.dart';
import 'package:flutter_ecomme_1/widget/materialbutton.dart';
import 'package:flutter_ecomme_1/widget/textfornfilder.dart';
import 'package:provider/provider.dart';

class singup extends StatelessWidget {
  singup({Key? key}) : super(key: key);
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  var _passworduser, _emailuser, _nameuser;
  @override
  Widget build(BuildContext context) {
    var hmqh = MediaQuery.of(context).size.height;
    var wmqw = MediaQuery.of(context).size.width;
    var authprovider = Provider.of<auth_provider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: kmaincolor,
            child: ListView(
              children: [
                SizedBox(
                  height: hmqh * 0.05,
                ),
                Container(
                  height: hmqh * 0.2,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image.asset('assets/icons/buyicon.png'),
                      const Positioned(
                          bottom: 1,
                          child: Text(
                            'buy it',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Pacifico',
                                fontSize: 25),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: hmqh * 0.05,
                ),
                defaulttextformfilder(
                    label1: 'Enter Your name',
                    hinttext: 'Enter Your name',
                    onsaved: (value) {
                      _nameuser = value;
                    },
                    prefixicon: Icon(
                      Icons.person,
                      color: kmaincolor,
                    ),
                    val: (value) {
                      if (value!.isEmpty || value == null) return '';
                    }),
                SizedBox(
                  height: 25,
                ),
                defaulttextformfilder(
                    onsaved: (value) {
                      _emailuser = value;
                    },
                    label1: 'Enter Your Email',
                    hinttext: 'Enter Your Email',
                    prefixicon: Icon(
                      Icons.email,
                      color: kmaincolor,
                    ),
                    val: (value) {
                      if (value!.isEmpty || value == null) return '';
                    }),
                SizedBox(
                  height: 25,
                ),
                defaulttextformfilder(
                    onsaved: (value) {
                      _passworduser = value;
                    },
                    label1: 'Enter Your PassWord',
                    obscuretext: true,
                    hinttext: 'Enter Your PassWord',
                    prefixicon: Icon(Icons.lock, color: kmaincolor),
                    val: (value) {
                      if (value!.isEmpty || value == null) return '';
                    }),
                SizedBox(
                  height: hmqh * 0.07,
                ),
                defaultbutton(
                    textcolor: Colors.white,
                    text: 'singup',
                    function: () {
                      var fromdata = _formKey.currentState;
                      if (fromdata!.validate() == true) {
                        fromdata.save();

                        authprovider.singup_method(
                            _emailuser, _passworduser, _nameuser, context);
                      }
                    },
                    background: Colors.black,
                    splashcolor: Colors.white),
                SizedBox(
                  height: hmqh * 0.11,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an accounte ?",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    defaultinkwellbutton(
                        text: ' Login',
                        textcolor: Colors.black,
                        fontsize: 18,
                        ontap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => login()));
                        })
                  ],
                ),
                SizedBox(
                  height: hmqh * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

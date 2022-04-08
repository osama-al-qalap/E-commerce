import 'package:flutter/material.dart';

import 'package:flutter_ecomme_1/provider/auth/auth_provider.dart';
import 'package:flutter_ecomme_1/screen/auth/singup.dart';
import 'package:flutter_ecomme_1/widget/textfornfilder.dart';
import 'package:provider/provider.dart';
import '../../provider/admin_user.dart';
import '../../widget/Inkwellbutton.dart';
import '../../widget/materialbutton.dart';
import '../../constant/const.dart';

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var _emailuser, _passworduser;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var hmqh = MediaQuery.of(context).size.height;
    var wmqw = MediaQuery.of(context).size.width;
    var authprovider = Provider.of<auth_provider>(context, listen: false);
    var adminuser = Provider.of<admin_user>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: kmaincolor,
          child: Form(
            key: _formKey,
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
                    label1: 'Enter Your Email',
                    hinttext: 'Enter Your Email',
                    prefixicon: Icon(
                      Icons.email,
                      color: kmaincolor,
                    ),
                    onsaved: (value) {
                      _emailuser = value;
                    },
                    val: (value) {
                      if (value!.isEmpty || value == null) return '';
                    }),
                const SizedBox(
                  height: 25,
                ),
                defaulttextformfilder(
                    label1: 'Enter Your PassWord',
                    obscuretext: true,
                    hinttext: 'Enter Your PassWord',
                    prefixicon: Icon(Icons.lock, color: kmaincolor),
                    onsaved: (value) {
                      _passworduser = value;
                    },
                    val: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please enter password';
                    }),
                SizedBox(
                  height: hmqh * 0.07,
                ),
                defaultbutton(
                  textcolor: Colors.white,
                  text: 'Login',
                  function: () {
                    var fromdata = _formKey.currentState;
                    if (fromdata!.validate() == true) {
                      fromdata.save();

                      authprovider.login_method(_emailuser, _passworduser,
                          adminuser.isadmin, context);
                    }
                  },
                  background: Colors.black,
                  splashcolor: Colors.white,
                ),
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
                        text: ' Sing up',
                        textcolor: Colors.black,
                        fontsize: 18,
                        ontap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => singup()));
                        })
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: defaultinkwellbutton(
                          ontap: () {
                            adminuser.chandegeisadmin(true);
                            print('44444${adminuser.isadmin}');
                          },
                          text: 'I\'m an admin',
                          textcolor:
                              Provider.of<admin_user>(context).isadmin == true
                                  ? kmaincolor
                                  : Colors.white),
                    ),
                    Expanded(
                      child: defaultinkwellbutton(
                          ontap: () {
                            adminuser.chandegeisadmin(false);
                            print('44444${adminuser.isadmin}');
                          },
                          text: 'I\'m user',
                          textcolor:
                              Provider.of<admin_user>(context).isadmin == true
                                  ? Colors.white
                                  : kmaincolor),
                    ),
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

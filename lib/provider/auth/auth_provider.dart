import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecomme_1/screen/admin/home_admin.dart';
import 'package:flutter_ecomme_1/screen/user/homePage.dart';
import 'package:flutter_ecomme_1/widget/showdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_ecomme_1/screen/auth/login.dart';
import 'package:flutter_ecomme_1/model/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';

class auth_provider extends ChangeNotifier {
  late UserCredential userCredential;
  FirebaseAuth auth = FirebaseAuth.instance;
  var userdata;
  var email;
  var name1;
  String get username {
    return name1;
  }

  user_model userModel = new user_model(email: '', name: '');

  Widget check_auth() {
    if (FirebaseAuth.instance.currentUser != null) {
      return homepageuser();
    } else {
      return login();
    }
  }

  singup_method(
      String email, String password, String name, BuildContext context) async {
    progressDialogue(context);
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user!.updateDisplayName(name);

      userdata = userCredential.user;
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'name': name,
        'email': email,
      });
      name1 = name;
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => homepageuser()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Navigator.pop(context);
        AwesomeDialog(
            context: context, body: Text('The password provided is too weak.'))
          ..show();
      } else if (e.code == 'email-already-in-use') {
        Navigator.pop(context);
        AwesomeDialog(
            context: context,
            body: Text('The account already exists for that email.'))
          ..show();
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  login_method(
      String email, String password, bool isadmin, BuildContext context) async {
    progressDialogue(context);

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      userdata = userCredential.user;
      await GetUser(email);
      Navigator.pop(context);
      if (isadmin == false) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => homepageuser()));
      } else {
        print(password.toString());
        if (password.toString() == '123456789')
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => home_admin()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.pop(context);
        AwesomeDialog(
            context: context, body: Text('No user found for that email.'))
          ..show();
      } else if (e.code == 'wrong-password') {
        Navigator.pop(context);
        AwesomeDialog(
            context: context,
            body: Text('Wrong password provided for that user.'))
          ..show();
      }
    }
    notifyListeners();
  }

  Logout_method(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => login()));
    notifyListeners();
  }

  Future<user_model> GetUser(email) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .get()
        .then((snapshot) {
      Map<String, dynamic>? data = snapshot.data();
      userModel = user_model(
        email: data!['email'],
        name: data['name'],
      );
      print(userModel);
    });

    return Future.value(userModel);
  }

  GetUserBYid(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) async {
      await GetUser(value.docs[0]['email']);
    });
  }
}

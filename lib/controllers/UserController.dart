import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:untitled_design/app/app.dart';
import 'package:untitled_design/app/modules/user/screens/home.dart';
import 'package:untitled_design/controllers/profileController.dart';

import 'adminHomeController.dart';
import 'medicalHistoryController.dart';


class UserController extends GetxController {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController otpController = new TextEditingController();

  String? refId;

  void signInUser(context) async {
    String email = emailController.text;
    String password = passwordController.text;
    await _getUsername();

    try {
      final User? user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      user!;
      emailController.clear();
      passwordController.clear();
      if (user.email == 'Aishaaljabri.521@gmail.com') {
        final adminHomeController = Get.put(AdminHomeController());
        await adminHomeController.getAllUsers();
        Get.offAll(AdminHome());
      } else {
        final profileController = Get.put(ProfileController());
        final medicalHistoryController = Get.put(MedicalHistoryController());
        await profileController.patchData();
        await medicalHistoryController.patchData();
        Get.to(UserHome());
        //Get.offAll(const UserHome());
      }
    } on FirebaseAuthException catch (_) {
      emailController.clear();
      passwordController.clear();
      showSnackBar("Incorrect username or Password!", context);
      onClose();
      // print('Failed with error code: ${e.code}');
      // print(e.message);
    }
  }

  void signUpUser(context) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);

    DocumentReference ref =
        await FirebaseFirestore.instance.collection('Users').add({
      'username': userNameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'password': passwordController.text,
    });

    ref.update({'userID': ref.id});

    userNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    showSnackBar("Signup Success", context);
  }

  void forgotPassword(context) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text);
    showSnackBar("Please check your email inbox!", context);
    emailController.clear();
  }

  void showSnackBar(String message, scaffoldContext) {
    final snackBar =
        SnackBar(content: Text(message), backgroundColor: Colors.teal);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    ScaffoldMessenger.of(scaffoldContext).showSnackBar(snackBar);
  }

  Future<void> _getUsername() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc['email'] == emailController.text) {
          userNameController.clear();
          userNameController.text = doc['username'];
          refId = doc['userID'];
          break;
        }
      }
    });
  }

  void DoContact(context, number123, name, phone) async {
    print(number123.toString() + "[1]");
    number123 = number123.toString();
    print(number123 + "[2]");
    String contact = "Contact_" +
        number123; //So we know which of the three contact we add/upd
    CollectionReference AllContacts =
    FirebaseFirestore.instance.collection('contacts');
    User? a = getUserInfo();
    try {
      AllContacts.doc(a?.uid).update({
        contact: [fixName(name), fixName(phone)]
      });
    } catch (e) {
      AllContacts.doc(a?.uid).update({
        "Contact_1": [fixName(name), fixName(phone)],
        "Contact_2": [fixName(name), fixName(phone)],
        "Contact_3": [fixName(name), fixName(phone)]
      });
    }
  }

  void index(String contact) {
    CollectionReference AllContacts =
    FirebaseFirestore.instance.collection('contacts');
    User? a = getUserInfo();
    try {
      AllContacts.doc(a?.uid).update({'index': '$contact'});
    } catch (e) {
      print("Error in Index method.");
    }
  }

  Future<String> readIndex() async {
    final db = FirebaseFirestore.instance;
    CollectionReference AllContacts =
    FirebaseFirestore.instance.collection('contacts');
    User? a = getUserInfo();
    String ind = "";
    try {
      await AllContacts.doc(a?.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        // Get value of field date from document
        ind = await documentSnapshot.get('index');
        print(ind + "[*]");
        return ind;
      });
    } catch (e) {
      print("Error in Index reading.");
    }
    return ind;
  }

  Future<String> readInfo(String info) async {
    final db = FirebaseFirestore.instance;
    CollectionReference AllContacts =
    FirebaseFirestore.instance.collection('contacts');
    User? a = getUserInfo();
    List ind;
    try {
      await AllContacts.doc(a?.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        // Get value of field date from document

        ind = await documentSnapshot.get('$info');

        print(ind[0].toString() + "[:Name]");
        return ind[0].toString();
      });
    } catch (e) {
      print("Error in reading Contact name.");
    }
    return "";
  }

  Future<String> readInfoPhone(String info) async {
    final db = FirebaseFirestore.instance;
    CollectionReference AllContacts =
    FirebaseFirestore.instance.collection('contacts');
    User? a = getUserInfo();
    List ind;
    try {
      await AllContacts.doc(a?.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        // Get value of field date from document

        ind = await documentSnapshot.get('$info');

        print(ind[1].toString() + "[:phone]");
        return ind[1].toString();
      });
    } catch (e) {
      print("Error in reading Contact phone.");
    }
    return "";
  }

  String fixName(name) {
    name = name.toString();
    return "'" + name + "'";
  }

  User? getUserInfo() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Get.to(UserHome());
  }
}

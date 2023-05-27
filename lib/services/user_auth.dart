import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

userLogin(
    TextEditingController emailCtrl, TextEditingController passCtrl) async {
  final auth = FirebaseAuth.instance;
  await auth.signInWithEmailAndPassword(
      email: emailCtrl.text, password: passCtrl.text);
}

userCreate({
  required TextEditingController nameCtrl,
  required TextEditingController emailCtrl,
  required TextEditingController passCtrl,
  required TextEditingController phoneCtrl,
  required File? profilePicFile,
  required TextEditingController ageCtrl,
  required TextEditingController cityCtrl,
}) async {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  String imgPath = 'assets/images/user_profile_pic.jpg';

  //create user
  UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: emailCtrl.text, password: passCtrl.text);

  //profile pic
  Reference ref = FirebaseStorage.instance.ref().child('${nameCtrl.text}.jpg');
  if (profilePicFile != null) {
    await ref.putFile(profilePicFile);
    ref.getDownloadURL().then((value) => imgPath = value);
  }

  //updating
  //await auth.signInWithEmailAndPassword(email: emailCtrl.text, password: passCtrl.text);
  //User user = auth.currentUser!;
  User user = userCredential.user!;

  await user.updateDisplayName(nameCtrl.text);
  await user.updatePhotoURL(imgPath);

  await user.reload();

  //for debuging and testing only
  //User? latestUser = FirebaseAuth.instance.currentUser;
  //print(latestUser!.displayName);
  //print(imgPath);

  db.collection('patients').doc(nameCtrl.text).set({
    'name': nameCtrl.text,
    'email': emailCtrl.text,
    'pass': passCtrl.text,
    'phone': phoneCtrl.text,
    'profilePic': imgPath,
    'age': ageCtrl.text,
    'city': cityCtrl.text,
  });
}

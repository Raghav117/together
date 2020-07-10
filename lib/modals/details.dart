import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

Future checkUser(num) async {
  bool registered = false;
  final firestoreInstance = Firestore.instance;

  await firestoreInstance.collection(num).document("profile").get().then(
      (value) =>
          value.exists == false ? registered = false : registered = true);
  return registered;
}

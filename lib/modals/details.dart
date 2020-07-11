import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:dart_geohash/dart_geohash.dart';

Future checkUser(num) async {
  bool registered = false;
  final firestoreInstance = Firestore.instance;

  await firestoreInstance.collection(num).document("profile").get().then(
      (value) =>
          value.exists == false ? registered = false : registered = true);
  return registered;
}

giveGeocode(Map m, int precision) {
  GeoHasher geoHasher = GeoHasher();
  var x = geoHasher.neighbors(geoHasher.encode(
      double.parse(m["longitude"]), double.parse(m["latitude"]),
      precision: precision));
  List<String> points = List();
  x.forEach((key, value) {
    points.add(value);
  });
  return points;
}

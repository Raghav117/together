import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:together/modals/models.dart';

Future checkRegisterdUSer(phone) async {
  bool registered = false;
  await Firestore.instance
      .collection("users")
      .document(phone)
      .get()
      .then((value) {
    if (value.data == null) {
      registered = false;
    } else {
      registered = true;
    }
  });
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

buildSet(String name, phone, dob, gender, password, url, username) {
  Set search = Set();
  Map<String, dynamic> data = Map();
  data["phone"] = phone;
  data["name"] = name;
  data["userid"] = username;
  data["gender"] = gender;
  data["password"] = password;
  data["purl"] = url;
  data["dob"] = dob;
  var x = name.toLowerCase().split(" ");
  for (var i in x) {
    int y = -1;
    while (++y != i.length) {
      search.add(i.substring(0, y + 1));
    }
  }
  x = username.toLowerCase().split(" ");
  for (var i in x) {
    int y = -1;
    while (++y != i.length) {
      search.add(i.substring(0, y + 1));
    }
  }
  x = phone.split(" ");
  for (var i in x) {
    int y = -1;
    while (++y != i.length) {
      search.add(i.substring(0, y + 1));
    }
  }
  print(search.toList());
  data["search"] = search.toList();
  return data;
}

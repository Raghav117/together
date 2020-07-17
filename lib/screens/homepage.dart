import 'dart:io';
import 'dart:math';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:together/screens/buildProfile.dart';
import 'buildTimeline.dart';

import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:location/location.dart';
import '../screens/buildPost.dart';
import 'package:together/modals/models.dart';
import 'package:together/screens/intrest.dart';
import 'package:together/screens/video.dart';
import 'package:video_player/video_player.dart';
import '../modals/details.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  double height, width;
  Own own = Own();
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  final firestoreInstance = Firestore.instance;

  int index;

  @override
  void initState() {
    _pageController = PageController();
    own.show();

    index = 0;
    super.initState();

    func();
  }

  func() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    if (_locationData != null) {
      Map<String, String> m = Map();
      m["longitude"] = _locationData.longitude.toString();
      m["latitude"] = _locationData.latitude.toString();
      own.m = m;
      updateLocation(m);
    }
  }

  //!---------------------------------------- Update Firestore Location ------------------------------------------------------------

  updateLocation(Map m) async {
    await firestoreInstance
        .collection("users")
        .document(own.phone)
        .get()
        .then((value) async {
      print(value.data);
      if (value.data["longitude"] != null) {
        Map<String, String> m = Map();
        m["longitude"] = value.data["longitude"];
        m["latitude"] = value.data["latitude"];

        removeRealLocation(value.data);
      }
      await firestoreInstance
          .collection("users")
          .document(own.phone)
          .updateData(m);
    }).then((value) {
      print(value);
      updateRealLocation(m);
    });
  }

  //!---------------------------------------- Remove Real Location Firebase------------------------------------------------------------

  removeRealLocation(Map m) {
    List list = giveGeocode(m, 5);
    int i = 0;
    print(list);
    var x;
    list.forEach((element) {
      x = FirebaseDatabase.instance.reference();
      for (i = 0; i != element.length; ++i) {
        x = x.child(element[i]);
      }
      x = x.child("mobile").child(own.phone).remove();
    });
  }

  //!---------------------------------------- Update Real Location Firebase------------------------------------------------------------

  updateRealLocation(Map m) {
    List list = giveGeocode(m, 5);
    int i = 0;
    print(list);
    var x;
    var element = list[8];
    // list.forEach((element) {
    x = FirebaseDatabase.instance.reference();
    for (i = 0; i != element.length; ++i) {
      x = x.child(element[i]);
    }
    x = x.child("mobile").child(own.phone).set("");
  }

  final items = [
    BottomNavyBarItem(
      activeColor: Colors.lightBlueAccent,
      icon: Icon(
        Icons.home,
        color: Colors.grey,
      ),
      title: Text("Timeline"),
    ),
    BottomNavyBarItem(
        activeColor: Colors.lightBlueAccent,
        icon: Icon(
          Icons.message,
          color: Colors.grey,
        ),
        title: Text("Messsage")),
    BottomNavyBarItem(
        activeColor: Colors.lightBlueAccent,
        icon: Icon(
          Icons.add,
          color: Colors.grey,
        ),
        title: Text("Post")),
    BottomNavyBarItem(
        activeColor: Colors.lightBlueAccent,
        icon: Icon(
          Icons.supervisor_account,
          color: Colors.grey,
        ),
        title: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: BottomNavyBar(
            selectedIndex: index,
            showElevation: true,
            onItemSelected: (index) => setState(() {
                  this.index = index;
                  print(index);
                  _pageController.jumpToPage(index);
                }),
            items: items),
        backgroundColor: Colors.white.withOpacity(0.90),
        body: SizedBox.expand(
            child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => this.index = index);
                },
                children: <Widget>[
              BuildTimeline(
                homepage: true,
              ),
              Container(
                color: Colors.blue,
              ),
              BuildPost(),
              Container(
                color: Colors.blue,
              ),
            ])));
  }
}

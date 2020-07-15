import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:together/design/styles.dart';
import 'package:together/modals/models.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:together/screens/buildTimeline.dart';
import 'buildScreen.dart';
import 'package:together/screens/video.dart';

class BuildProfile extends StatefulWidget {
  final String phone;

  const BuildProfile({Key key, this.phone}) : super(key: key);
  @override
  _BuildProfileState createState() => _BuildProfileState();
}

class _BuildProfileState extends State<BuildProfile> {
  bool tag;
  List<int> untagged;
  List<Profile> profiletag;
  bool loading;
  List<Profile> profileuntag;
  User user;

  @override
  void dispose() {
    print("ua");
    super.dispose();
  }

  @override
  void initState() {
    loading = true;
    tag = false;
    profiletag = List();
    profileuntag = List();

    loadProfile();
    super.initState();
  }

  loadProfile() async {
    await Firestore.instance
        .collection(widget.phone)
        .document("profile")
        .get()
        .then((value) {
      // print(value.data["gender"]);
      user = User.fromaMap(value.data, widget.phone);
      // print(user.show());
    });
    await Firestore.instance
        .collection(widget.phone)
        .document("timeline")
        .collection("main")
        .getDocuments()
        .then((value) {
      value.documents.forEach((element) {
        profileuntag.add(Profile.fromaMap(element.data));
      });
    });
    loading = false;
    print("yeah");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: loading == false
          ? Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Container(
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 0.5,
                              offset: Offset(2.0, 0.5))
                        ]),
                        height: height / 16,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "  Profile",
                                style: appName,
                              ),
                              IconButton(
                                icon: Icon(Icons.message),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return Scaffold(
                                  body: SafeArea(
                                    child: Container(
                                      height: height,
                                      width: width,
                                      child: Stack(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.start,
                                        children: <Widget>[
                                          CachedNetworkImage(
                                            imageUrl: user.imageUrl,
                                            fit: BoxFit.contain,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(
                                                  Icons
                                                      .photo_size_select_actual,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {},
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {},
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ));
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: height / 5,
                                width: height / 5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: CachedNetworkImage(
                                    imageUrl: user.imageUrl,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "Following",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("135")
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "Followers",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("828")
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "Posts",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("92")
                            ],
                          ),
                        ],
                      ),
                      ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  content: Container(
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                            onTap: () {},
                                            leading: IconButton(
                                              icon: Icon(
                                                Icons.person,
                                                color: Colors.lightBlueAccent,
                                              ),
                                              onPressed: () {},
                                            ),
                                            trailing: Icon(Icons.edit),
                                            title: Text(
                                              "Name",
                                              style: GoogleFonts.openSans(),
                                            ),
                                            subtitle: Text(
                                              user.name,
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Divider(),
                                        ListTile(
                                            onTap: () {},
                                            leading: IconButton(
                                              icon: Icon(
                                                Icons.info,
                                                color: Colors.lightBlueAccent,
                                              ),
                                              onPressed: () {},
                                            ),
                                            trailing: Icon(Icons.edit),
                                            title: Text(
                                              "About",
                                              style: GoogleFonts.openSans(),
                                            ),
                                            subtitle: Text(
                                              "",
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Divider(),
                                        ListTile(
                                            onTap: () {},
                                            leading: Icon(
                                              Icons.phone,
                                              color: Colors.lightBlueAccent,
                                            ),
                                            trailing: Icon(Icons.edit),
                                            title: Text(
                                              "Mobile No",
                                              style: GoogleFonts.openSans(),
                                            ),
                                            subtitle: Text(
                                              user.phone,
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Divider(),
                                        ListTile(
                                            onTap: () {},
                                            leading: Icon(
                                              Icons.calendar_today,
                                              color: Colors.lightBlueAccent,
                                            ),
                                            trailing: Icon(Icons.edit),
                                            title: Text(
                                              "DOB",
                                              style: GoogleFonts.openSans(),
                                            ),
                                            subtitle: Text(
                                              user.dob,
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Divider(),
                                        ListTile(
                                            onTap: () {},
                                            leading: Icon(
                                              Icons.group_work,
                                              color: Colors.lightBlueAccent,
                                            ),
                                            trailing: Icon(Icons.edit),
                                            title: Text(
                                              "Gender",
                                              style: GoogleFonts.openSans(),
                                            ),
                                            subtitle: Text(
                                              user.gender,
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Divider(),
                                        ListTile(
                                          onTap: () {},
                                          leading: Icon(
                                            Icons.insert_emoticon,
                                            color: Colors.lightBlueAccent,
                                          ),
                                          isThreeLine: true,
                                          trailing: Icon(Icons.edit),
                                          title: Text(
                                            "Intrests",
                                            style: GoogleFonts.openSans(),
                                          ),
                                          subtitle:
                                              Text("Tap here to see Intrestes"),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          title: Text(
                            user.name,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Tap for more info...",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(),
                          )),
                      tag == true
                          ? Column(
                              children: profileuntag
                                  .map((e) => buildTile2(height, width, e))
                                  .toList(),
                            )
                          : Column(
                              children: profileuntag
                                  .map((e) => buildTile(height, width, e))
                                  .toList(),
                            )
                    ],
                  ),
                  tag == false
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                tag = !tag;
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              // height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: gradient,
                              ),
                              child: Center(
                                child: Text(
                                  "Tag",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                tag = !tag;
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: gradient,
                              ),
                              child: Center(
                                child: Text(
                                  "UnTag",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Container buildTile(double height, double width, Profile p) {
    return Container(
      height: height / 6,
      width: width,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Container(
                  width: 2,
                  height: height / 5,
                  decoration: BoxDecoration(gradient: gradient),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: gradient),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            // padding: EdgeInsets.all(10),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  gradient: gradient, borderRadius: BorderRadius.circular(25)),
              height: height,
              width: width - 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  p.purl.length != 0
                      ? InkWell(
                          onTap: () {
                            print("yeah");
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return MakeScreen(
                                  p: p,
                                );
                              },
                            ));
                          },
                          child: Container(
                            width: height / 6,
                            height: height,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: height / 6,
                                  height: height,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                        imageUrl: p.purl[0], fit: BoxFit.cover),
                                  ),
                                ),
                                p.purl.length > 1
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Icon(Icons.import_contacts,
                                              size: 15, color: Colors.white),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  p.vurl.length != 0
                      ? Container(
                          // width: width,
                          height: height,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: VideoEidget(
                                url: p.vurl,
                                aspect: false,
                              )),
                        )
                      : Container(),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: AutoSizeText(
                              p.text,
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildTile2(double height, double width, Profile p) {
    return Container(
      height: height / 6,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  gradient: gradient, borderRadius: BorderRadius.circular(25)),
              height: height,
              width: width - 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: AutoSizeText(p.text,
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5)),
                      ],
                    ),
                  ),
                  p.purl.length != 0
                      ? InkWell(
                          onTap: () {
                            print("yeah");
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return MakeScreen(
                                  p: p,
                                );
                              },
                            ));
                          },
                          child: Container(
                            width: height / 6,
                            height: height,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: height / 6,
                                  height: height,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                        imageUrl: p.purl[0], fit: BoxFit.cover),
                                  ),
                                ),
                                p.purl.length > 1
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Icon(Icons.import_contacts,
                                              size: 15, color: Colors.white),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  p.vurl.length != 0
                      ? Container(
                          width: height / 5,
                          height: height,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: VideoEidget(
                                url: p.vurl,
                                aspect: false,
                              )),
                        )
                      : Container()
                ],
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Container(
                  width: 2,
                  height: height / 4,
                  decoration: BoxDecoration(gradient: gradient),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: gradient),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

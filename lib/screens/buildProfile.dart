import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:together/design/styles.dart';
import 'package:together/modals/models.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:together/screens/buildTimeline.dart';
import 'package:together/screens/video.dart';

class BuildProfile extends StatefulWidget {
  @override
  _BuildProfileState createState() => _BuildProfileState();
}

class _BuildProfileState extends State<BuildProfile> {
  bool tag;
  Own own;
  List<int> untagged;
  List<Profile> profiletag;
  bool loading;
  List<Profile> profileuntag;

  @override
  void initState() {
    own = Own();
    loading = true;
    tag = false;
    profiletag = List();
    profileuntag = List();
    untagged = List();
    for (int i = 0; i < 10; ++i) {
      untagged.add(1);
    }
    loadProfile();
    super.initState();
  }

  loadProfile() async {
    await Firestore.instance
        .collection(own.phone)
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
    return loading == false
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
                              icon: Icon(Icons.settings),
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
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Scaffold(
                                backgroundColor: Colors.black,
                                body: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(
                                            Icons.photo_size_select_actual,
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
                                    SizedBox(
                                      height: 100,
                                    ),
                                    Image.network(
                                      own.imageUrl,
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
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
                                child: Image.network(
                                  own.imageUrl,
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
                                            own.name,
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
                                            own.phone,
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
                                            own.dob,
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
                                            own.gender,
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
                          "Raghav Garg",
                          textAlign: TextAlign.center,
                          style:
                              GoogleFonts.openSans(fontWeight: FontWeight.bold),
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
                            width: 20,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: gradient,
                            ),
                            child: Center(
                              child: Text(
                                "T  a  g  g  e  d",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Align(
                        // left: 0,
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              tag = !tag;
                            });
                          },
                          child: Container(
                            width: 20,
                            height: 190,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: gradient,
                              // color: Colors.lightBlueAccent
                            ),
                            child: Center(
                              child: Text(
                                "U   n   t   a  g  g  e  d",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
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
          );
  }

  Container buildTile(double height, double width, Profile p) {
    return Container(
      height: height / 4,
      width: width,
      // height: double.infinity,
      // width: double.infinity,
      // color: Colors.amber,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
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
                      gradient: gradient
                      // color: Colors.amber,
                      ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  gradient: gradient,
                  // color: Colors.pink,

                  borderRadius: BorderRadius.circular(25)),
              // color: Colors.pink,
              height: height,
              width: width - 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  p.purl.length != 0
                      ? Container(
                          width: height / 5,
                          height: height,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: height / 5,
                                height: height,
                                // color: Colors.black,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(p.purl[0],
                                      fit: BoxFit.cover),
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
                        )
                      : Container(),
                  p.vurl.length != 0
                      ? Container(
                          width: height / 5,
                          height: height,
                          // color: Colors.black,
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
                    child: InkWell(
                      onTap: () {
                        print("yeah");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return BuildTimeline(
                              timeline: profileuntag,
                              homepage: true,
                            );
                          },
                        ));
                      },
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: AutoSizeText(
                                p.text,
                                // style: TextStyle(fontSize: 20),
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 8,

                                // maxLines: 2,
                              )),
                        ],
                      ),
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
      height: height / 4,
      width: width,
      // decoration: BoxDecoration(gradient: gradient),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  gradient: gradient,
                  // color: Colors.pink,

                  borderRadius: BorderRadius.circular(25)),
              // color: Colors.pink,
              height: height,
              width: width - 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        print("yeah");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return BuildTimeline(
                              timeline: profileuntag,
                            );
                          },
                        ));
                      },
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: AutoSizeText(
                                p.text,
                                // style: TextStyle(fontSize: 20),
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 8,

                                // maxLines: 2,
                              )),
                          // Expanded(),
                          // Align(
                          //   alignment: Alignment.bottomCenter,
                          //   child: Container(
                          //     // width: 5,
                          //     // padding: EdgeInsets.only(right: 5),
                          //     child: Text(
                          //       "25-05-2019",
                          //       style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 13,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  p.purl.length != 0
                      ? Container(
                          width: height / 5,
                          height: height,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: height / 5,
                                height: height,
                                // color: Colors.black,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(p.purl[0],
                                      fit: BoxFit.cover),
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
                        )
                      : Container(),
                  p.vurl.length != 0
                      ? Container(
                          width: height / 5,
                          height: height,
                          // color: Colors.black,
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
                      gradient: gradient
                      // color: Colors.amber,
                      ),
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

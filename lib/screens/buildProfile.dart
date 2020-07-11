import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:together/design/styles.dart';
import 'package:together/modals/models.dart';
import 'package:together/screens/video.dart';

class BuildProfile extends StatefulWidget {
  @override
  _BuildProfileState createState() => _BuildProfileState();
}

class _BuildProfileState extends State<BuildProfile> {
  bool tag = false;
  Own own;
  List<int> untagged;

  @override
  void initState() {
    own = Own();
    untagged = List();
    for (int i = 0; i < 10; ++i) {
      untagged.add(1);
    }
    super.initState();
  }

  List<Profile> profile = List();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                                      "Raghav Garg",
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
                                      "+919012220988",
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
                                      "06/12/1999",
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
                                      "Female",
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
                                  subtitle: Text("Tap here to see Intrestes"),
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
                    style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Tap for more info...",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(),
                  )),
              tag == true
                  ? Column(
                      children: profile
                          .map((e) => buildTile2(height, width, e))
                          .toList(),
                    )
                  : Column(
                      children: untagged
                          .map((e) => buildTile(height, width))
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
    );
  }

  Container buildTile(double height, double width) {
    return Container(
      height: height / 5,
      width: width,
      // color: Colors.amber,
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
                      gradient: gradient
                      // color: Colors.amber,
                      ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(25),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  gradient: gradient,
                  // color: Colors.pink,

                  borderRadius: BorderRadius.circular(20)),
              // color: Colors.pink,
              height: height,
              width: width - 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQPFy6H9GeQPb9K4cqtn6NIvj_nhQNTztXrzQ&usqp=CAU",
                        fit: BoxFit.contain),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(
                            "25-05-2019",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          height: 50,
                          width: width - 240,
                          decoration: BoxDecoration(
                              // gradient: gradient,
                              ),
                          child: Text(
                            "This is that day where I spent my day with my selves and with friends",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )
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
      height: height / 5,
      width: width,
      // decoration: BoxDecoration(
      //     border: Border.all(width: 1, color: Colors.lightBlueAccent)),
      // color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(25),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  // color: Colors.pink,
                  gradient: reverseGradient,
                  borderRadius: BorderRadius.circular(20)),
              // color: Colors.pink,
              height: height,
              width: width - 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(
                            p.date,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          height: 50,
                          width: width - 240,
                          child: Text(
                            p.text,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  p.purl.length != 0
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(p.purl[0].toString(),
                              fit: BoxFit.contain),
                        )
                      : SizedBox(),
                  p.vurl.length != 0
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: VideoWidget(
                            play: true,
                            url: p.vurl,
                          ))
                      : SizedBox()
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
                  height: height / 5,
                  decoration: BoxDecoration(
                    gradient: reverseGradient,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: reverseGradient,
                    // color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      // child: Row(
      //   children: <Widget>[
      //     SizedBox(
      //       width: 10,
      //     ),
      // Stack(
      //   children: <Widget>[
      //     Padding(
      //       padding: const EdgeInsets.only(left: 6.0),
      //       child: Container(
      //         width: 2,
      //         height: height / 5,
      //         color: Colors.blue,
      //       ),
      //     ),
      //     Align(
      //       alignment: Alignment.center,
      //       child: Container(
      //         width: 15,
      //         height: 15,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(20),
      //           color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
      //               .withOpacity(1.0),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      //     Padding(
      //       padding: EdgeInsets.all(25),
      //       child: Container(
      //         alignment: Alignment.centerLeft,
      //         decoration: BoxDecoration(
      //             // color: Colors.pink,
      //             borderRadius: BorderRadius.circular(20)),
      //         // color: Colors.pink,
      //         height: height,
      //         width: width - 100,
      //         child: Row(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: <Widget>[
      //             ClipRRect(
      //               borderRadius: BorderRadius.circular(10),
      //               child: Image.network(
      //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQPFy6H9GeQPb9K4cqtn6NIvj_nhQNTztXrzQ&usqp=CAU",
      //                   fit: BoxFit.contain),
      //             ),
      //             Column(
      //               children: <Widget>[
      //                 Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Container(
      //                     child: Text(
      //                       "25-05-2019",
      //                       style: TextStyle(color: Colors.red),
      //                     ),
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.only(left: 15),
      //                   child: Container(
      //                     height: 50,
      //                     width: width - 240,
      //                     child: Text(
      //                         "This is that day where I spent my day with my selves and with friends"),
      //                   ),
      //                 )
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

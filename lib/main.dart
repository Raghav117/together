import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:together/design/styles.dart';
import 'package:together/screens/registration.dart';
import 'package:together/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modals/details.dart';
import 'modals/models.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Together",
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController userid;
  TextEditingController password;
  bool pass;
  bool registered;
  bool loading;
  final firestoreInstance = Firestore.instance;
  @override
  void initState() {
    pass = false;
    loading = false;
    autoLogIn();
    userid = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  //!   ************************************************    Auto Login     *************************************

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var js = prefs.getString('js');

    if (js != null) {
      var x = json.decode(js);
      Own own = Own.fromaMap(x);
      own.show();
      Navigator.pop(context);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
    }
  }

//! ********************************************************  ToDo  Login Method   ********************************************************

  // login() async {
  //   await _auth.currentUser().then((user) {
  //     if (user != null) {
  //       try {
  //         firestoreInstance
  //             .collection("user").where(field)
  //             .document().
  //             .get()
  //             .then((value) {
  //           if (value.exists) {
  //             Map<dynamic, dynamic> m = value.data;
  //             Own r = Own.fromaMap(m, user.phoneNumber.toString());
  //             print(user.phoneNumber);
  //             r.show();
  //             Navigator.of(context).pop();
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (BuildContext context) => HomePage(),
  //                 ));
  //           } else {
  //             _auth.signOut();
  //             setState(() {
  //               loading = false;
  //             });
  //           }
  //         });
  //       } catch (e) {
  //         setState(() {
  //           loading = false;
  //           print("Not USer");
  //         });
  //       }
  //     } else {
  //       setState(() {
  //         print("No");

  //         loading = false;
  //       });
  //     }
  //   });
  // }

  // Future<String> checkUser(num, password) async {
  //   String registered = "";

  //   return registered;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading == false
          ? SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/download.jpg')),
                  Text(
                    "Together",
                    style: appHeading,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      child: new TextField(
                        controller: userid,
                        decoration: new InputDecoration(
                            counterText: 'User ID / Mobile No.',
                            labelText: 'User ID / Mobile No.',
                            hintText: 'User ID / Mobile No.',
                            prefixIcon: Icon(Icons.supervisor_account)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 10),
                    child: Container(
                      child: new TextField(
                        controller: password,
                        obscureText: !pass ? true : false,
                        decoration: new InputDecoration(
                            counterText: "Password",
                            labelText: "Password",
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.security),
                            suffix: IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: pass ? Colors.blue : Colors.black,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    pass = !pass;
                                  });
                                })),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () async {
                            if (userid.text.length != 0 &&
                                password.text.length != 0) {
                              setState(() {
                                loading = true;
                              });
                              Firestore.instance
                                  .collection("users")
                                  .document(userid.text)
                                  .get()
                                  .then((value) {
                                if (value.data == null) {
                                  Firestore.instance
                                      .collection("users")
                                      .where("userid", isEqualTo: userid.text)
                                      .getDocuments()
                                      .then((value) async {
                                    if (value.documents.length == 0) {
                                      print("Not Registered");
                                      setState(() {
                                        loading = false;
                                      });
                                      // print("none");
                                    } else {
                                      print("password is ");
                                      if (value.documents[0].data["password"] ==
                                          password.text) {
                                        Map<dynamic, dynamic> m =
                                            value.documents[0].data;
                                        Own r = Own.fromaMap(m);
                                        print(num);
                                        r.show();
                                        print("Yes");
                                        final prefs = await SharedPreferences
                                            .getInstance();

                                        prefs.setString(
                                            "js",
                                            json.encode(
                                                value.documents[0].data));
                                        // Navigator.pop(context);
                                        // Navigator.of(context)
                                        //     .push(MaterialPageRoute(
                                        //   builder: (context) => HomePage(),
                                        // ));
                                      } else {
                                        print("Invalid Password");
                                        setState(() {
                                          loading = false;
                                        });
                                      }
                                      // print();
                                    }
                                  });
                                } else {
                                  if (value.data["password"] == password.text) {
                                    Map<dynamic, dynamic> m = value.data;
                                    Own r = Own.fromaMap(m);
                                    print(num);
                                    r.show();
                                    print("Yes");
                                    Navigator.pop(context);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ));
                                  } else {
                                    print("Invalid Password");

                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                }
                              });
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF000080).withOpacity(0.9),
                                    Colors.lightBlue
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Log In",
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PhoneRegistration(
                                          forgot: true,
                                        )));
                              },
                              child: Text("Forgot Password")),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  FlatButton(
                    child: Container(
                        height: 30,
                        child: Center(child: Text("Create New Account"))),
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PhoneRegistration(
                        forgot: false,
                      ),
                    )),
                  )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

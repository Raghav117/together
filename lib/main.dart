import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:together/design/styles.dart';
import 'package:together/screens/buildProfile.dart';
import 'package:together/screens/buildTimeline.dart';
import 'package:together/screens/intrest.dart';
import 'package:together/screens/registration.dart';
import 'package:together/screens/homepage.dart';

import 'modals/details.dart';
import 'modals/models.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Together",
    // home: MyApp(),
    home: BuildProfile(
      phone: "+919012220988",
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool pass;
  bool registered;
  FirebaseAuth _auth;

  String errorUser;
  bool loading;
  String errorPassword;
  final firestoreInstance = Firestore.instance;
  @override
  void initState() {
    pass = false;
    _auth = FirebaseAuth.instance;

    loading = true;
    num = "";
    login();
    password = "";
    super.initState();
  }

//! ********************************************************  Login Method   ********************************************************

  login() async {
    await _auth.currentUser().then((user) {
      if (user != null) {
        try {
          firestoreInstance
              .collection(user.phoneNumber)
              .document("profile")
              .get()
              .then((value) {
            if (value.exists) {
              Map<dynamic, dynamic> m = value.data;
              Own r = Own.fromaMap(m, user.phoneNumber.toString());
              print(user.phoneNumber);
              r.show();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(),
                  ));
            } else {
              _auth.signOut();
              setState(() {
                loading = false;
              });
            }
          });
        } catch (e) {
          setState(() {
            loading = false;
            print("Not USer");
          });
        }
      } else {
        setState(() {
          print("No");

          loading = false;
        });
      }
    });
  }

  String num;
  String password;

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
                        onChanged: (value) => num = value,
                        onSubmitted: (value) => num = value,
                        decoration: new InputDecoration(
                            counterText: 'User ID / Mobile No.',
                            labelText: 'User ID / Mobile No.',
                            hintText: 'User ID / Mobile No.',
                            errorText: errorUser,
                            prefixIcon: Icon(Icons.supervisor_account)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 10),
                    child: Container(
                      child: new TextField(
                        onChanged: (value) => password = value,
                        onSubmitted: (value) => password = value,
                        obscureText: !pass ? true : false,
                        decoration: new InputDecoration(
                            counterText: "Password",
                            errorText: errorPassword,
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
                            if (num.length != 0 && password.length != 0) {
                              setState(() {
                                loading = true;
                              });
                              if (!await checkUser(num)) {
                                errorUser = "Not Registered";
                                setState(() {
                                  loading = false;
                                });
                              } else {
                                firestoreInstance
                                    .collection(num)
                                    .document("profile")
                                    .get()
                                    .then((value) {
                                  print(value.data);
                                  print(value.data["password"]);
                                  if (value.data["password"] != password) {
                                    errorPassword = "Wrong Password";
                                    setState(() {
                                      loading = false;
                                    });
                                  } else {
                                    Map<dynamic, dynamic> m = value.data;
                                    Own r = Own.fromaMap(m, num);
                                    print(num);
                                    r.show();
                                    Navigator.pop(context);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ));
                                  }
                                });
                              }
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

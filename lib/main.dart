import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:together/design/styles.dart';
import 'package:together/screens/intrest.dart';
import 'package:together/screens/registration.dart';
import 'package:together/screens/homepage.dart';

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
  // final FirebaseUser user;
  bool pass;
  bool registered;
  FirebaseAuth _auth;

  String errorUser;
  bool loading;
  String errorPassword;
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
        print(user.phoneNumber);
        final databaseReference = FirebaseDatabase.instance.reference();
        try {
          databaseReference
              .child(user.phoneNumber)
              .once()
              .then((DataSnapshot snapshot) {
            if (snapshot.value != null) {
              // Map<dynamic, dynamic> m = snapshot.value;
              // Record r = Record.fromaMap(m, user.phoneNumber);
              // r.show();
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
            // error = e;
          });
        }
      } else {
        setState(() {
          print("dfasdf");

          loading = false;
        });
      }
    });
  }

  Future checkUser() async {
    final databaseReference = FirebaseDatabase.instance.reference();
    print(num);
    await databaseReference.child(num).once().then((value) =>
        value.value == null ? registered = false : registered = true);
    return registered;
  }

  String num;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     "Together",
      //     style: appName,
      //   ),
      //   centerTitle: true,
      // ),
      body: loading == false
          ? SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
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
                      // decoration: BoxDecoration(
                      //     gradient: LinearGradient(
                      //         begin: Alignment.topLeft,
                      //         end: Alignment.bottomRight,
                      //         colors: [Colors.orange, Colors.white, Colors.green])),
                      child: new TextField(
                        onChanged: (value) => num = value,
                        onSubmitted: (value) => num = value,

                        // textAlign: TextAlign.center,

                        decoration: new InputDecoration(
                            counterText: 'User ID / Mobile No.',
                            // hintStyle: appName,
                            labelText: 'User ID / Mobile No.',
                            hintText: 'User ID / Mobile No.',
                            errorText: errorUser,
                            prefixIcon: Icon(Icons.supervisor_account)
                            // border: OutlineInputBorder()
                            // border: new OutlineInputBorder(
                            // borderRadius: const BorderRadius.all(
                            //   // const Radius.circular(0.0),
                            // ),
                            // borderSide: new BorderSide(
                            //   color: Colors.black,
                            //   width: 1.0,
                            // ),
                            // ),
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 10),
                    child: Container(
                      // decoration: BoxDecoration(
                      //     gradient: LinearGradient(
                      //         begin: Alignment.topLeft,
                      //         end: Alignment.bottomRight,
                      //         colors: [Colors.orange, Colors.white, Colors.green])),
                      child: new TextField(
                        // textAlign: TextAlign.center,
                        onChanged: (value) => password = value,
                        onSubmitted: (value) => password = value,
                        obscureText: !pass ? true : false,
                        decoration: new InputDecoration(
                            counterText: "Password",
                            errorText: errorPassword,
                            // prefixText: "passeord",
                            // counterText: "passwored",
                            labelText: "Password",
                            // hintStyle: appName,
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
                                })

                            // border: OutlineInputBorder()
                            // border: new OutlineInputBorder(
                            // borderRadius: const BorderRadius.all(
                            //   // const Radius.circular(0.0),
                            // ),
                            // borderSide: new BorderSide(
                            //   color: Colors.black,
                            //   width: 1.0,
                            // ),
                            // ),
                            ),
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
                              if (!await checkUser()) {
                                errorUser = "Not Registered";
                                setState(() {
                                  loading = false;
                                });
                              } else {
                                final databaseRefrence =
                                    FirebaseDatabase.instance.reference();
                                databaseRefrence
                                    .child(num)
                                    .once()
                                    .then((value) {
                                  print(value.value);
                                  print(value.value["password"]);
                                  if (value.value["password"] != password) {
                                    errorPassword = "Wrong Password";
                                    setState(() {
                                      loading = false;
                                    });
                                  } else {
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
                                        )
                                    // PhoneRegistration(
                                    //       forgot: true,
                                    //     )

                                    ));
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

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:together/design/styles.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:together/modals/details.dart';
import 'package:together/modals/models.dart';
import 'package:together/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:together/screens/intrest.dart';

class PhoneRegistration extends StatefulWidget {
  final bool forgot;

  const PhoneRegistration({Key key, this.forgot}) : super(key: key);
  @override
  _PhoneRegistrationState createState() => _PhoneRegistrationState(forgot);
}

class _PhoneRegistrationState extends State<PhoneRegistration> {
  final firestoreInstance = Firestore.instance;

  PhoneNumber mobileNo;
  final bool forgot;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> _gender = ['Female', 'Male', 'Other'];
  int igender;
  String password;
  FirebaseUser user;

  String confirmPassword;

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  bool validateNumber;
  int page;
  String errorNumber;
  String verificationId;
  String otp;
  bool loading;

  DateTime _date;

  bool pass;
  bool cpass;

  String errorMessage;
  String name;
  bool registered;
  var file;
  _PhoneRegistrationState(this.forgot);

  Future getCurrentUser() async {
    user = await _auth.currentUser();
    print(user);
  }

  Future registerUser(String mobile, BuildContext context) async {
    try {
      _auth.verifyPhoneNumber(
          phoneNumber: mobile,
          timeout: Duration(minutes: 2),
          verificationCompleted: (cridential) {},
          verificationFailed: (exception) {
            setState(() {
              loading = false;
            });
          },
          codeSent: (String verificationId, [int forceSendingToken]) {
            this.verificationId = verificationId;
            setState(() {
              loading = false;
              page = 1;
            });
          },
          codeAutoRetrievalTimeout: (timeout) {});
    } catch (e) {
      print(e.toString());
    }
  }

  handleError(error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        setState(() {
          loading = false;
          errorMessage = 'Invalid Code';
        });
        Navigator.of(context).pop();

        break;
      default:
        setState(() {
          loading = false;
          errorMessage = error.message;
        });

        break;
    }
  }

  String passwordValidation;
  String confirmPasswordValidation;
  String errorUserid;

  @override
  void initState() {
    validateNumber = false;
    loading = false;
    errorUserid = "";
    name = "";
    password = "";
    userid.addListener(() {
      Firestore.instance
          .collection("users")
          .where("username", isEqualTo: userid.text.toLowerCase())
          .getDocuments()
          .then((value) {
        if (value.documents.length == 0) {
          if (errorUserid != "") {
            setState(() {
              errorUserid = "";
            });
          }
        } else {
          if (errorUserid != "This User Id is already taken") {
            setState(() {
              errorUserid = "This User Id is already taken";
            });
          }
        }
      });
    });
    confirmPassword = "";
    super.initState();
    page = 0;
    igender = 0;
    pass = false;
    cpass = false;
  }

  Future<bool> _willPopCallback() async {
    if (page == 4 && forgot == false || page == 3) {
      page = page - 1;
      setState(() {});
    } else {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black, opacity: 0.4),
            title: Text(
              "Together",
              style: appName,
            ),
          ),
          // body: buildUsername(width, height),
          body: loading == false
              ? page == 1
                  ? buildOTP(width, height)
                  : page == 0
                      ? buildMobileNumber(height)
                      : page == 2
                          ? buildProfile(height, width, context)
                          : page == 3
                              ? buildUsername(width, height)
                              : buildPassword(width, height)
              : Center(child: CircularProgressIndicator()),
        ));
  }

  TextEditingController userid = TextEditingController();

  Widget buildUsername(double width, double height) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: height / 8,
            ),
            Text(
              "Set your User Id",
              style: appMobile,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40),
              child: Container(
                width: width,
                height: 40,
                child: Text(
                  "A User Id gives you unique personality and helps you for identifing uniquely...",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: Container(
                child: new TextField(
                  controller: userid,
                  decoration: new InputDecoration(
                    // labelText: "New Password",
                    hintText: 'User Id',
                    errorText: errorUserid.length == 0 ? null : errorUserid,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    prefixIcon: Icon(Icons.supervised_user_circle),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height / 8,
            ),
            errorUserid.length == 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: InkWell(
                      onTap: () {
                        Firestore.instance
                            .collection("users")
                            .where("username",
                                isEqualTo: userid.text.toLowerCase())
                            .getDocuments()
                            .then((value) {
                          if (value.documents.length == 0) {
                            setState(() {
                              page = 4;
                            });
                          } else {
                            setState(() {
                              errorUserid = "This User Id is already taken";
                            });
                          }
                        });
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
                              "Confirm User ID",
                              style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget buildPassword(double width, double height) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: height / 8),
              forgot == false
                  ? Text("Set Password", style: appMobile)
                  : Text("Set New Password", style: appMobile),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                child: Container(
                  width: width,
                  height: 40,
                  child: Text(
                    "A strong password has prevent unauthorized access to your account.",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 10),
                    child: Container(
                      child: new TextField(
                        obscureText: !pass ? true : false,
                        onChanged: (value) => password = value,
                        onSubmitted: (value) => password = value,
                        decoration: new InputDecoration(
                            labelText: "New Password",
                            hintText: 'New Password',
                            errorText: passwordValidation,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: Container(
                      child: new TextField(
                        obscureText: !cpass ? true : false,
                        onChanged: (value) => confirmPassword = value,
                        onSubmitted: (value) =>
                            confirmPasswordValidation = value,
                        decoration: new InputDecoration(
                            errorText: confirmPasswordValidation,
                            labelText: "Confirm New Password",
                            hintText: 'Confirm New Password',
                            prefixIcon: Icon(Icons.security),
                            suffix: IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: cpass ? Colors.blue : Colors.black,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    cpass = !cpass;
                                  });
                                })),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: height / 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: InkWell(
              onTap: () async {
                Own own = Own();

                if (confirmPassword != password) {
                  print("eroro 1");
                  setState(() {
                    confirmPasswordValidation = "Passwords must be same";
                  });
                } else if (password.length < 8) {
                  print("eroro 2");

                  passwordValidation = "Weak Password";
                } else {
                  loading = true;
                  setState(() {});
                  StorageReference storageReference;
                  String url = "";
                  await getCurrentUser();

                  try {
                    if (file != null) {
                      storageReference = FirebaseStorage.instance
                          .ref()
                          .child("images/${user.phoneNumber + name}");
                      final StorageUploadTask uploadTask =
                          storageReference.putFile(File(file.path));
                      final StorageTaskSnapshot downloadUrl =
                          (await uploadTask.onComplete);
                      url = (await downloadUrl.ref.getDownloadURL());
                      own.imageUrl = url;
                    }
                    if (forgot == false) {
                      try {
                        Map<String, dynamic> data = buildSet(
                            name,
                            user.phoneNumber.toString(),
                            _date.toString(),
                            _gender[igender],
                            password,
                            url,
                            userid.text);
                        await firestoreInstance
                            .collection("users")
                            .document(user.phoneNumber)
                            // await firestoreInstance
                            //     .collection(user.phoneNumber)
                            //     .document("profile")
                            .setData(data);

                        own.name = name;
                        own.dob = _date.day.toString() +
                            "-" +
                            _date.month.toString() +
                            "-" +
                            _date.year.toString();
                        own.gender = _gender[igender];
                        own.phone = user.phoneNumber.toString();
                        own.userid = userid.text;

                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => IntrestScreen()));
                      } catch (e) {
                        print(e.toString());
                      }
                    } else {
                      await firestoreInstance
                          .collection("users")
                          .document(user.phoneNumber)
                          .updateData({'password': password});

                      await firestoreInstance
                          .collection("users")
                          .document(user.phoneNumber)
                          .get()
                          .then((value) {
                        Map<dynamic, dynamic> m = value.data;
                        own = Own.fromaMap(m);
                        own.show();
                      });

                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  } catch (e) {
                    loading = false;
                    setState(() {});
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
                      "Confirm",
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView buildProfile(
      double height, double width, BuildContext context) {
    print(_gender[igender]);
    print(_date);
    if (user == null) getCurrentUser();
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: height / 16,
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      content: Container(
                        height: width / 3,
                        child: Column(
                          children: <Widget>[
                            FlatButton(
                              child: Text("Gallery"),
                              onPressed: () async {
                                Navigator.of(context).pop();

                                file = await ImagePicker.platform
                                    .pickImage(source: ImageSource.gallery);
                                if (file != null) {
                                  file = await FlutterImageCompress
                                      .compressAndGetFile(
                                    file.path,
                                    "/data/user/0/com.example.together/cache/image.jpg",
                                    quality: 30,
                                  );
                                  print(File(file.path).lengthSync());
                                }
                                setState(() {});
                              },
                            ),
                            FlatButton(
                              child: Text("Camera"),
                              onPressed: () async {
                                Navigator.of(context).pop();

                                file = await ImagePicker.platform
                                    .pickImage(source: ImageSource.camera);
                                if (file != null) {
                                  file = await FlutterImageCompress
                                      .compressAndGetFile(
                                    file.path,
                                    "/data/user/0/com.example.together/cache/image.jpg",
                                    quality: 30,
                                  );
                                  print(File(file.path).lengthSync());
                                }
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: width / 2,
                width: width / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF000080).withOpacity(0.9),
                      Colors.lightBlue
                    ],
                  ),
                ),
                child: file == null
                    ? Icon(
                        Icons.account_circle,
                        size: width / 2,
                        color: Colors.white,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(file.path),
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(
            height: height / 16,
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  child: new TextField(
                    onChanged: (value) => name = value,
                    onSubmitted: (value) => name = value,
                    autocorrect: true,
                    decoration: new InputDecoration(
                        labelText: 'Name',
                        hintText: 'Name',
                        errorText: errorNumber,
                        prefixIcon: Icon(Icons.supervisor_account)),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.person_outline,
                          color: Colors.blue,
                        ),
                        Text(
                          "  Gender",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    DropdownButton<String>(
                      value: _gender[igender],
                      items: _gender.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(
                            value,
                          ),
                          onTap: () => igender = _gender.indexOf(value),
                        );
                      }).toList(),
                      onChanged: (_) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "🎂 Birthday",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    FlatButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(0, 0, 0),
                              maxTime: DateTime.now(),
                              theme: DatePickerTheme(
                                  backgroundColor: Colors.white,
                                  itemStyle: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  doneStyle: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16)), onChanged: (date) {
                            _date = date;
                            setState(() {});
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          }, onConfirm: (date) {
                            _date = date;
                            setState(() {});
                            print('confirm $date');
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black.withOpacity(0.1),
                                      width: 1))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  _date == null
                                      ? 'Date Of Birth'
                                      : _date.day.toString() +
                                          "/" +
                                          _date.month.toString() +
                                          "/" +
                                          _date.year.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: height / 8,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: InkWell(
              onTap: () {
                if (name.length == 0) {
                  setState(() {
                    errorNumber = "Empty";
                  });
                } else if (_date == null) {
                } else {
                  setState(() {
                    page = 3;
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
                      "Next",
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildOTP(double width, double height) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: height / 16,
          ),
          Container(
              width: width,
              child: Center(child: Image.asset("assets/otp.png"))),
          Column(
            children: <Widget>[
              Text(
                "OTP Verification",
                style: appMobile,
              ),
              SizedBox(
                height: height / 16,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Enter the OTP sents to "),
                    Text(
                      mobileNo.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: height / 16,
          ),
          Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: PinCodeTextField(
                  length: 6,
                  textInputType: TextInputType.number,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      activeColor: Colors.blue,
                      inactiveColor: Colors.black,
                      selectedColor: Colors.black),
                  onCompleted: (v) {
                    otp = v;
                  },
                  onChanged: (value) {
                    otp = value;
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");

                    return true;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't recieve the OTP?"),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000080).withOpacity(0.9)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: height / 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: InkWell(
              onTap: () async {
                setState(() {
                  loading = true;
                });
                try {
                  var _credential = PhoneAuthProvider.getCredential(
                      verificationId: verificationId, smsCode: otp);
                  await _auth.signInWithCredential(_credential).then((value) {
                    forgot == false ? page = 2 : page = 4;
                    setState(() {
                      loading = false;
                    });
                  }).catchError((e) {
                    setState(() {
                      loading = false;
                    });
                    print(e);
                  });
                } catch (e) {
                  handleError(e);
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
                      "VERIFY & PROCEED",
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildMobileNumber(double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        forgot == false
            ? Text(
                "Enter your mobile number",
                style: appMobile,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "Enter your resgistered mobile number",
                  style: appMobile,
                ),
              ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: InternationalPhoneNumberInput(
                countrySelectorScrollControlled: true,
                onInputChanged: (PhoneNumber number) {
                  mobileNo = number;
                  print(number.phoneNumber);
                },
                onSubmit: () {
                  if (validateNumber == false) {
                    setState(() {
                      errorNumber = "Wrong Number";
                    });
                  }
                },
                autoValidate: true,
                onInputValidated: (bool value) {
                  validateNumber = value;
                  print(value);
                },
                errorMessage: errorNumber,
                inputDecoration: InputDecoration(labelText: "Mobile Number"),
                initialValue: number,
                textFieldController: controller,
                inputBorder: OutlineInputBorder(),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Container(
                  width: double.infinity,
                  height: height / 8,
                  child: Center(
                      child: forgot == false
                          ? Text(
                              "Tap Next to verify your account with your mobile number."
                              "You don't need to manually enter verification code if the number install in this phone...",
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              "By tapping Next an OTP will be sent to your registered mobile number by using which you can change your password...",
                              textAlign: TextAlign.center,
                            )),
                )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: InkWell(
            onTap: () async {
              if (validateNumber == true) {
                setState(() {
                  loading = true;
                });
                if (forgot == false) {
                  registered = await checkRegisterdUSer(mobileNo.toString());
                  if (registered == false) {
                    await registerUser(mobileNo.toString(), context);
                  } else {
                    errorNumber = "Already Registered";
                    loading = false;
                    setState(() {});
                  }
                } else {
                  registered = await checkRegisterdUSer(mobileNo.toString());
                  if (registered == false) {
                    setState(() {
                      errorNumber = "Not Registered";
                      loading = false;
                    });
                  } else {
                    await registerUser(mobileNo.toString(), context);
                  }
                }

                print("Next");
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
                    "Next",
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:together/design/styles.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:together/screens/homepage.dart';
// import 'lib/screens/homepage.dart';
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
  PickedFile file;
  _PhoneRegistrationState(this.forgot);

  Future getCurrentUser() async {
    print("yeaj");
    user = await _auth.currentUser();
    print(user);
  }

  Future checkUser() async {
    final databaseReference = FirebaseDatabase.instance.reference();
    print(mobileNo);
    await databaseReference.child(mobileNo.toString()).once().then((value) =>
        value.value == null ? registered = false : registered = true);
    return registered;
  }

  Future registerUser(String mobile, BuildContext context) async {
    try {
      _auth.verifyPhoneNumber(
          phoneNumber: mobile,
          timeout: Duration(minutes: 2),
          verificationCompleted: (cridential) {
            print("Cefdad" + cridential.toString());
          },
          verificationFailed: (exception) {
            setState(() {
              loading = false;
            });
            print("exceptopm" + exception.message);
          },
          codeSent: (String verificationId, [int forceSendingToken]) {
            this.verificationId = verificationId;
            // print(code);
            setState(() {
              loading = false;
              page = 1;
            });
          },
          codeAutoRetrievalTimeout: (timeout) {
            print("timeout");
          });
    } catch (e) {
      setState(() {
        loading == false;
      });
      print(e.toString());
    }
  }

  handleError(error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        // FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          loading = false;
          errorMessage = 'Invalid Code';
        });
        Navigator.of(context).pop();
        // smsOTPDialog(context);
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

  @override
  void initState() {
    validateNumber = false;
    loading = false;
    name = "";
    password = "";
    confirmPassword = "";
    super.initState();
    // errorNumber;
    // mobileNo = "";
    page = 0;
    igender = 0;
    pass = false;
    cpass = false;
  }

  Future<bool> _willPopCallback() async {
    // bool result = false;
    if (page == 3 && forgot == false) {
      page = 2;
      setState(() {});
    } else {
      return true;
    }
    // print(result);
    return false; // return true if the route to be popped
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
            // elevation: ,
            iconTheme: IconThemeData(color: Colors.black, opacity: 0.4),
            title: Text(
              "Together",
              style: appName,
            ),
          ),
          // body: page != 3
          //     ? buildProfile(height, width, context)
          //     : buildPassword(width, height),
          body: loading == false
              ? page == 1
                  ? buildOTP(width)
                  : page == 0
                      ? buildMobileNumber(height)
                      : page == 2
                          ? buildProfile(height, width, context)
                          : buildPassword(width, height)
              : Center(child: CircularProgressIndicator()),
        ));
  }

  Widget buildPassword(double width, double height) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
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
                        obscureText: !pass ? true : false,

                        onChanged: (value) => password = value,
                        // autofocus: true,
                        onSubmitted: (value) => password = value,
                        decoration: new InputDecoration(
                            // counterText: "Password",

                            // prefixText: "passeord",
                            // counterText: "passwored",
                            labelText: "New Password",
                            // hintStyle: appName,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: Container(
                      // decoration: BoxDecoration(
                      //     gradient: LinearGradient(
                      //         begin: Alignment.topLeft,
                      //         end: Alignment.bottomRight,
                      //         colors: [Colors.orange, Colors.white, Colors.green])),
                      child: new TextField(
                        // textAlign: TextAlign.center,
                        obscureText: !cpass ? true : false,
                        onChanged: (value) => confirmPassword = value,
                        onSubmitted: (value) =>
                            confirmPasswordValidation = value,
                        // autofocus: true,
                        decoration: new InputDecoration(
                            // counterText: "Confirm Password",
                            // prefixText: "passeord",
                            errorText: confirmPasswordValidation,
                            // counterText: "passwored",
                            labelText: "Confirm New Password",
                            // hintStyle: appName,
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
                ],
              ),
            ],
          ),
          SizedBox(height: height / 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: InkWell(
              onTap: () async {
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
                  final databaseReference =
                      FirebaseDatabase.instance.reference();
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
                    }
                    if (forgot == false) {
                      try {
                        await databaseReference.child(user.phoneNumber).set({
                          'name': name,
                          'dob': _date.toString(),
                          'gender': _gender[igender],
                          'password': password,
                          'purl': url
                          // 'email': r.email
                        });
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => IntrestScreen()));
                      } catch (e) {
                        print(e.toString());
                      }
                    } else {
                      await databaseReference
                          .child(user.phoneNumber)
                          .update({'password': password});

                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                    print("URL is $url");
                    print("completed");
                    ;
                  } catch (e) {
                    loading = false;
                    setState(() {});
                    print("roornaw " + e.toString());
                  }

                  // // Navigator.of(context).pop();
                  // // Navigator.of(context).pop();
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => HomePage()));
                }
              },
              // child: InkWell(
              //   onTap: () {
              //     // Navigator.pop();
              //   Navigator.of(context).pop();
              //   Navigator.of(context).pop();
              //   Navigator.of(context)
              //       .push(MaterialPageRoute(builder: (context) => HomePage()));
              // },
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
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
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
                                setState(() {});
                              },
                            ),
                            FlatButton(
                              child: Text("Camera"),
                              onPressed: () async {
                                Navigator.of(context).pop();

                                file = await ImagePicker.platform
                                    .pickImage(source: ImageSource.camera);
                                setState(() {});
                              },
                            ),
                            // FlatButton(
                            //   child:
                            //       Text("Only Share with..."),
                            //   onPressed: () {},
                            // ),
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
                        child: Image.asset(
                          file.path,
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
                  // decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //         begin: Alignment.topLeft,
                  //         end: Alignment.bottomRight,
                  //         colors: [Colors.orange, Colors.white, Colors.green])),
                  child: new TextField(
                    onChanged: (value) => name = value,
                    onSubmitted: (value) => name = value,
                    // textAlign: TextAlign.center,
                    autocorrect: true,
                    decoration: new InputDecoration(
                        // counterText: 'Name',
                        // hintStyle: appName,
                        labelText: 'Name',
                        hintText: 'Name',
                        errorText: errorNumber,
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
                          // strutStyle: StrutStyle(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    DropdownButton<String>(
                      // icon:
                      // elevation: 20,
                      // hint: Text("Gendere"),
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
                                  // headerColor: Colors.blue,
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
                              // borderRadius: BorderRadius.circular(20),
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black.withOpacity(0.1),
                                      width: 1))
                              // gradient: LinearGradient(
                              //   colors: [
                              //     Color(0xFF000080).withOpacity(0.9),
                              //     Colors.lightBlue
                              //   ],
                              // ),
                              ),
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
                                    // fontWeight: FontWeight.bold,
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

  Widget buildOTP(double width) {
    return SingleChildScrollView(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              width: width,
              child: Center(child: Image.asset("assets/otp.png"))),
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "OTP Verification",
                style: appMobile,
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
          Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: PinCodeTextField(
                  length: 6,
                  textInputType: TextInputType.number,

                  // obsecureText: false,
                  // animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      activeColor: Colors.blue,
                      inactiveColor: Colors.black,
                      selectedColor: Colors.black
                      // selectedColor: Color(0xFF000080).withOpacity(0.9)
                      // borderRadius: BorderRadius.circular(20)
                      // borderRadius: BorderRadius.circular(5),
                      // fieldHeight: 50,
                      // fieldWidth: 40,
                      // activeFillColor: Colors.white,
                      ),
                  // animationDuration: Duration(milliseconds: 300),
                  // backgroundColor: Colors.blue.shade50,
                  // enableActiveFill: true,
                  // errorAnimationController: errorController,
                  // controller: textEditingController,
                  onCompleted: (v) {
                    otp = v;
                    // print("Completed");
                  },
                  onChanged: (value) {
                    otp = value;
                  },

                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
              //!  ---------------------------------------------------- To Do ----------------------------------------------------------------------------
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
                    forgot == false ? page = 2 : page = 3;
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
      // crossAxisAlignment: CrossAxisAlignment.end,
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
                // countries: [],

                countrySelectorScrollControlled: true,
                // keyboardAction: TextInputAction.n,

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
                // hintText: "Mobile Number",
                inputDecoration: InputDecoration(
                    // counterText: "Mobile Number",
                    // hintText: "Mobile Number",
                    labelText: "Mobile Number"
                    // counterText: "Mobile Number"
                    ),

                // ignoreBlank: false,
                // autoValidate: false,
                // selectorTextStyle: TextStyle(color: Colors.black),
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
                  registered = await checkUser();
                  if (registered == false) {
                    await registerUser(mobileNo.toString(), context);
                  } else {
                    errorNumber = "Already Registered";
                    loading = false;
                    setState(() {});
                  }
                } else {
                  registered = await checkUser();
                  if (registered == false) {
                    setState(() {
                      errorNumber = "Not Registered";
                      loading = false;
                    });
                  } else {
                    await registerUser(mobileNo.toString(), context);
                  }
                }
                // var number = mobileNo.toString().substring(1);
                // print(number);
                print("Next");
                // setState(() {
                //   errorNumber = "Wrong Number";
                // });
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

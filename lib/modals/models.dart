import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class User {
  String gender;
  String imageUrl;
  String name;
  String hobies;
  String dob;
  String phone;
  String userid;
  String password;

  show() {
    print(gender);
    print(dob);
    print(name);
    print(imageUrl);
    print(hobies);
    print(phone);
  }

  User.fromaMap(value) {
    this.gender = value['gender'];
    this.dob = value['dob'];
    this.name = value['name'];
    this.hobies = value['hobies'];
    this.userid = value['userid'];
    this.phone = value["phone"];
    this.imageUrl = value['purl'];
  }
}

class Own {
  String gender;
  String imageUrl;
  String name;
  String hobies;
  String dob;
  String phone;
  String userid;
  String password;

  Map m;

  static final Own _own = Own._internal();

  factory Own() {
    return _own;
  }

  Own.fromaMap(value) {
    _own.gender = value['gender'];
    _own.userid = value['userid'];
    _own.dob = value['dob'];
    _own.name = value['name'];
    _own.hobies = value['hobies'];
    _own.phone = value['phone'];
    _own.imageUrl = value["purl"];
  }

  show() {
    print(gender);
    print(dob);
    print(name);
    print(imageUrl);
    print(hobies);
    print(phone);
  }

  Own._internal();
}

class Profile {
  String text;
  String vurl;
  List purl;
  String date;
  String name;
  String imageUrl;
  String phone;
  String userid;

  Profile.fromaMap(value) {
    this.text = value['text'];
    this.purl = value['purl'];
    this.vurl = value['vurl'];
    this.date = value['date'];
    this.name = value['name'];
    this.imageUrl = value['imageurl'];
    this.phone = value['phone'];
    this.userid = value['userid'];
  }

  show() {}
}

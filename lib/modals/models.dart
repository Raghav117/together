import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class User {
  String gender;
  String imageUrl;
  String name;
  String hobies;
  String dob;
  String phone;
  Map m;
  show() {
    print(gender);
    print(dob);
    print(name);
    print(imageUrl);
    print(hobies);
    print(phone);
  }

  User.fromaMap(value, no) {
    this.gender = value['gender'];
    this.dob = value['dob'];
    this.name = value['name'];
    this.hobies = value['hobies'];
    this.phone = no.toString();
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

  Map m;

  static final Own _own = Own._internal();

  factory Own() {
    return _own;
  }

  Own.fromaMap(value, no) {
    _own.gender = value['gender'];
    _own.dob = value['dob'];
    _own.name = value['name'];
    _own.hobies = value['hobies'];
    _own.phone = no.toString();
    _own.imageUrl = value['purl'];
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

  Profile.fromaMap(value) {
    this.text = value['text'];
    this.purl = value['purl'];
    this.vurl = value['vurl'];
    this.date = value['date'];
    this.name = value['name'];
    this.imageUrl = value['imageurl'];
  }

  show() {}
}

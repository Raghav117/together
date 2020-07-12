import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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
  // static final Profile _profile = Profile._internal();

  // factory Profile() {
  //   return _profile;
  // }

  Profile.fromaMap(value) {
    this.text = value['text'];
    this.purl = value['purl'];
    this.vurl = value['vurl'];
    this.date = value['date'];
  }

  show() {
    // print(gender);
    // print(dob);
    // print(name);
    // print(imageUrl);
    // print(hobies);
    // print(phone);
  }

  // Profile._internal();
}

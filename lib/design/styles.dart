import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_text/gradient_text.dart';

TextStyle appName = GoogleFonts.montez(fontSize: 27, color: Colors.black);
TextStyle appHeading = GoogleFonts.montez(fontSize: 40, color: Colors.black);
TextStyle appLogin = TextStyle(fontSize: 27, color: Colors.white);
TextStyle appMobile =
    TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold);
var gradient = LinearGradient(
  colors: [Color(0xFF000080).withOpacity(0.8), Colors.lightBlueAccent],
);
var reverseGradient = LinearGradient(
  colors: [
    Colors.lightBlueAccent,
    Color(0xFF000080).withOpacity(0.8),
  ],
);

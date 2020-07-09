import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:together/design/styles.dart';
import 'package:together/screens/homepage.dart';

class IntrestScreen extends StatefulWidget {
  @override
  _IntrestScreenState createState() => _IntrestScreenState();
}

class _IntrestScreenState extends State<IntrestScreen> {
  List<bool> grid;
  List<String> gridName;
  double height, width;
  int choose;
  @override
  void initState() {
    grid = List();
    choose = 0;
    gridName = List();
    fillGrid();
    for (int i = 0; i < 13; ++i) grid.add(false);
    // grid.insertAll(13, )
    // grid.forEach((element) {return false;});
    super.initState();
  }

  fillGrid() {
    gridName.add("Entertainment");
    gridName.add("Fashion");
    gridName.add("Books");
    gridName.add("Politics");
    gridName.add("Health & Fitness");
    gridName.add("Technology");
    gridName.add("Travel");
    gridName.add("Spiritual");
    gridName.add("Food");
    gridName.add("Business");
    gridName.add("General Knowledge");
    gridName.add("Sports");
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.white,
                  Colors.lightBlueAccent.withOpacity(0.5),
                  // Colors.blue,
                ])),
          ),
          SafeArea(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: height / 18,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: width,
                          child: Text("Choose your Interest...",
                              textAlign: TextAlign.center,
                              strutStyle: StrutStyle(height: 2),
                              style: GoogleFonts.ubuntu(
                                fontSize: 20,
                              )),
                        ),
                        Container(
                          width: width,
                          child: Text("At Least 5...",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ubuntu(
                                fontSize: 13,
                              )),
                        )
                      ],
                    )),
                Flexible(
                    child: GridView.builder(
                  itemCount: 12,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    // double x =
                    return Padding(
                      padding:
                          EdgeInsets.all(2 + Random().nextInt(20).toDouble()),
                      child: InkWell(
                        onTap: () {
                          grid[index] = !grid[index];
                          if (grid[index] == true) {
                            ++choose;
                          } else {
                            --choose;
                          }
                          setState(() {});
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              gridName[index],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          // height: 20,
                          // width: 60,
                          decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              gradient: grid[index] == true ? gradient : null,
                              borderRadius: BorderRadius.circular(40),
                              color: grid[index] == true
                                  ? null
                                  : Colors.transparent.withOpacity(0.1)),
                        ),
                      ),
                    );
                  },
                  // gridDelegate: SilverGridDelegateWithFixedCrossAxisCount(),
                )),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 18),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
                          },
                        ));
                      },
                      child: Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: choose >= 5 ? gradient : null,
                            color: choose < 5
                                ? Colors.transparent.withOpacity(0.2)
                                : null),
                        child: Center(
                          child: Text(
                            "Next -->",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
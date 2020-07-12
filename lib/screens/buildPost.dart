import 'package:flutter/material.dart';
import '../design/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';
// import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:video_player/video_player.dart';
import '../modals/details.dart';
import '../modals/models.dart';

class BuildPost extends StatefulWidget {
  @override
  _BuildPostState createState() => _BuildPostState();
}

class _BuildPostState extends State<BuildPost> {
  bool post = false;
  String text = "";
  List<Asset> images = List<Asset>();
  Own own;

  final firestoreInstance = Firestore.instance;
  VideoPlayerController _videoPlayerController;

  File file;

  String _error;

  bool loading;
  @override
  void initState() {
    own = Own();
    loading = false;
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();

    if (file != null)
      await _videoPlayerController.dispose().catchError((onError) {
        print(onError);
      });
    file = null;
    images.clear();
    text = "";
    print("post dispose");
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return loading == false
        ? SafeArea(
            child: Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 0.5,
                              offset: Offset(2.0, 0.5))
                        ]),
                        height: height / 16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Center(
                              child: Text(
                                "  Together",
                                style: appName,
                              ),
                            ),
                            FlatButton(
                              onPressed: post == true
                                  ? () async {
                                      await postUpload();
                                    }
                                  : null,
                              child: Text(
                                "Post    ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: post == false
                                        ? Colors.black
                                        : Colors.blue),
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/profile.jpg",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Raghav PAgea",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                content: Container(
                                                  height: width / 2,
                                                  child: Column(
                                                    children: <Widget>[
                                                      FlatButton(
                                                        child: Text("Everyone"),
                                                        onPressed: () {},
                                                      ),
                                                      FlatButton(
                                                        child:
                                                            Text("Supporters"),
                                                        onPressed: () {},
                                                      ),
                                                      FlatButton(
                                                        child: Text(
                                                            "Only Share with..."),
                                                        onPressed: () {},
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Row(
                                              children: <Widget>[
                                                Text("Everyone "),
                                                Icon(Icons.keyboard_arrow_down)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: 1,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                hintText: "What do you want to share ???",
                                disabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none),
                            onChanged: (value) {
                              text = value;
                              print("object");
                              if (value.length == 0)
                                setState(() {
                                  post = false;
                                });

                              if (value.length != 0) if (post == false)
                                setState(() {
                                  post = true;
                                });
                            },
                            onSubmitted: (value) {
                              text = value;
                            },
                          ),
                        ),
                      ),
                      // Container(
                      //   child: TextField(
                      //     textInputAction: TextInputAction.newline,
                      //     keyboardType: TextInputType.multiline,
                      //     maxLines: null,
                      //     minLines: 1,
                      //     decoration: InputDecoration(
                      //         hintText: "   What do you want to share ???",
                      //         disabledBorder: InputBorder.none,
                      //         border: InputBorder.none,
                      //         enabledBorder: InputBorder.none),
                      //     onChanged: (value) {
                      //       print("object");
                      //       if (value.length == 0)
                      //         setState(() {
                      //           post = false;
                      //         });

                      //       if (value.length != 0) if (post == false)
                      //         setState(() {
                      //           post = true;
                      //         });
                      //     },
                      //     onSubmitted: (value) {},
                      //   ),
                      // ),
                      images.length != 0
                          ? Expanded(
                              child: buildGridView(),
                            )
                          : Container(),
                      file != null
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    children: <Widget>[
                                      AspectRatio(
                                        aspectRatio: _videoPlayerController
                                            .value.aspectRatio,
                                        child:
                                            VideoPlayer(_videoPlayerController),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.lightBlueAccent,
                                        ),
                                        onPressed: () async {
                                          // await _videoPlayerController.dispose();
                                          file = null;
                                          print(file);
                                          setState(() {});
                                          if (file == null) {
                                            await _videoPlayerController
                                                .dispose();
                                          }
                                          // setState(() {});
                                          // setState(() {});
                                        },
                                      )
                                    ],
                                  );
                                },
                              ),
                            )
                          : SizedBox(),
                      // file!=null? Expanded(
                      //   child: buildGridView(),
                      // ),Containe()
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          onPressed: images.length < 3 && file == null
                              ? loadAssets
                              : null,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.photo_album),
                              Text(
                                "Photo",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        FlatButton(
                          onPressed: images.length == 0
                              ? () async {
                                  if (file != null) {
                                    await _videoPlayerController.dispose();
                                    // file = null;
                                    setState(() {});
                                  }
                                  file = await FilePicker.getFile(
                                      allowedExtensions: ["mp4", "mkv"],
                                      type: FileType.custom);
                                  if (file != null) {
                                    print("File length is " +
                                        file.lengthSync().toString());
                                    _videoPlayerController =
                                        VideoPlayerController.file(file);
                                    await _videoPlayerController.initialize();
                                    await _videoPlayerController.play();
                                    await _videoPlayerController
                                        .setLooping(true);
                                    setState(() {});
                                  }
                                }
                              : null,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.missed_video_call),
                              Text(
                                "Video",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        FlatButton(
                          onPressed: images.length == 0
                              ? () async {
                                  if (file != null) {
                                    await _videoPlayerController.dispose();
                                    // file = null;
                                    setState(() {});
                                  }
                                  file = await FilePicker.getFile(
                                      allowedExtensions: ["mp3"],
                                      // file.
                                      type: FileType.custom);
                                  if (file != null) {
                                    print("File length is " +
                                        file.lengthSync().toString());
                                    _videoPlayerController =
                                        VideoPlayerController.file(file);
                                    await _videoPlayerController.initialize();
                                    await _videoPlayerController.play();
                                    await _videoPlayerController
                                        .setLooping(true);
                                    setState(() {});
                                  }
                                }
                              : null,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.audiotrack),
                              Text(
                                "Audio",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Stack(
          children: <Widget>[
            AssetThumb(
              asset: asset,
              width: 300,
              height: 300,
            ),
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.lightBlueAccent,
                ),
                onPressed: () {
                  images.removeAt(index);
                  setState(() {});
                })
          ],
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    print(error);

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  //!---------------------------------------- Post Upload ------------------------------------------------------------

  postUpload() async {
    loading = true;
    setState(() {});
    StorageReference storageReference;
    String vUrl = "";
    List<String> pUrl = List();

    if (file != null) {
      try {
        storageReference = FirebaseStorage.instance
            .ref()
            .child('videos/${own.phone + own.name}}');
        StorageUploadTask uploadTask =
            storageReference.putFile(File(file.path));
        StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
        vUrl = await downloadUrl.ref.getDownloadURL();

        print('File Uploaded');
        loading = false;
      } catch (e) {
        print(e.toString());
      }
      file = null;
      setState(() {});
      if (file == null) await _videoPlayerController.dispose();
    }

    if (images.length != 0) {
      List<File> files = [];
      for (Asset asset in images) {
        final filePath =
            await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
        files.add(File(filePath));
      }

      for (var f in files) {
        try {
          storageReference =
              FirebaseStorage.instance.ref().child("images/${f.path}");
          StorageUploadTask uploadTask = storageReference.putFile(File(f.path));
          StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
          pUrl.add(await downloadUrl.ref.getDownloadURL());
          print('File Uploaded');
        } catch (e) {
          print(e);
        }
      }
    }

    String path;
    DateTime dateTime;
    dateTime = DateTime.now();
    String date = dateTime.day.toString() +
        "-" +
        dateTime.month.toString() +
        "-" +
        dateTime.year.toString();

    await firestoreInstance
        .collection(own.phone)
        .document("timeline")
        .collection("main")
        .add({
      "text": text,
      "purl": pUrl,
      "vurl": vUrl,
      "date": date,
    }).then((value) {
      print(value.path);
      path = value.path;
    });

    images.clear();
    file = null;
    print('Successfull');
    loading = false;
    setState(() {});
    postToLocation(path);
  }

  //!---------------------------------------- Post for location ------------------------------------------------------------

  postToLocation(String path) {
    print(own.m);

    List list = giveGeocode(own.m, 5);
    int i = 0;
    print(list);
    var x;

    list.forEach((element) {
      x = FirebaseDatabase.instance.reference();
      for (i = 0; i != element.length; ++i) {
        x = x.child(element[i]);
      }

      x.child("mobile").once().then((value) async {
        value.value.forEach((key, value) async {
          if (key != own.phone) {
            await firestoreInstance
                .collection(key)
                .document("timeline")
                .collection(own.gender)
                .document("path")
                .setData({path: "path"});
          }
        });
      });
      print("Completed");
    });
  }
}

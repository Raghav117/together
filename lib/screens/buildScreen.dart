import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:together/modals/models.dart';
import 'package:together/screens/video.dart';

class MakeScreen extends StatefulWidget {
  final Profile p;

  const MakeScreen({Key key, this.p}) : super(key: key);
  @override
  _MakeScreenState createState() => _MakeScreenState();
}

class _MakeScreenState extends State<MakeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Stack(
          children: <Widget>[
            Swiper(
              pagination: SwiperPagination.dots,
              // layout: SwiperLayout.STACK,
              // itemWidth: width,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.p.purl[index],
                  fit: BoxFit.contain,
                );
              },
              itemCount: widget.p.purl.length,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                widget.p.text,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        )),
      ),
    );
  }
}

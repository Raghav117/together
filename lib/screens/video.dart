import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_video_player/cached_video_player.dart';

class VideoEidget extends StatefulWidget {
  final String url;
  final bool aspect;
  final bool doubletab;

  const VideoEidget(
      {Key key, this.url, this.aspect = false, this.doubletab = true})
      : super(key: key);
  @override
  _VideoEidgetState createState() => _VideoEidgetState();
}

class _VideoEidgetState extends State<VideoEidget> {
  CachedVideoPlayerController cachedVideoPlayerController;
  @override
  void initState() {
    cachedVideoPlayerController =
        CachedVideoPlayerController.network(widget.url);
    cachedVideoPlayerController.initialize();
    cachedVideoPlayerController.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    cachedVideoPlayerController.dispose();
    print("deisplos");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (cachedVideoPlayerController.value.isPlaying) {
          cachedVideoPlayerController.pause();
        } else {
          cachedVideoPlayerController.play();
        }
        setState(() {});
      },
      onDoubleTap: widget.doubletab == true
          ? () async {
              cachedVideoPlayerController.pause();

              await Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) {
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    body: VideoEidget(
                      url: widget.url,
                      doubletab: false,
                      aspect: true,
                    ),
                  );
                },
              ));
            }
          : null,
      // child: Container(

      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: AspectRatio(
              aspectRatio: widget.aspect == false
                  ? 1
                  : cachedVideoPlayerController.value.aspectRatio,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedVideoPlayer(cachedVideoPlayerController)),
            ),
          ),
          cachedVideoPlayerController.value.isPlaying == false
              ? Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.play_arrow, color: Colors.white, size: 30),
                )
              : SizedBox()
        ],
        // ),
      ),
    );
  }
}

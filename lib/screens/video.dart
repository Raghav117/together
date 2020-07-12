import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoEidget extends StatefulWidget {
  final String url;
  final bool aspect;

  const VideoEidget({Key key, this.url, this.aspect = false}) : super(key: key);
  @override
  _VideoEidgetState createState() => _VideoEidgetState();
}

class _VideoEidgetState extends State<VideoEidget> {
  VideoPlayerController videoPlayerController;
  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.url);
    videoPlayerController.initialize();
    videoPlayerController.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    print("deisplos");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (videoPlayerController.value.isPlaying) {
          videoPlayerController.pause();
        } else {
          videoPlayerController.play();
        }
        setState(() {});
      },
      // child: Container(

      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: AspectRatio(
              aspectRatio: widget.aspect == false
                  ? 1
                  : videoPlayerController.value.aspectRatio,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: VideoPlayer(videoPlayerController)),
            ),
          ),
          videoPlayerController.value.isPlaying == false
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

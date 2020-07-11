import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final bool play;
  final String url;

  const VideoWidget({Key key, @required this.url, @required this.play})
      : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState(url, play);
}

class _VideoWidgetState extends State<VideoWidget> {
  final String url;
  final bool play;
  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;

  _VideoWidgetState(this.url, this.play);

  @override
  void initState() {
    super.initState();
    videoPlayerController = new VideoPlayerController.network(widget.url);

    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      //       Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });

    @override
    void dispose() {
      videoPlayerController.dispose();
      //    widget.videoPlayerController.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            height: 100,
            width: 100,
            child: Chewie(
              key: new PageStorageKey(widget.url),
              controller: ChewieController(
                videoPlayerController: videoPlayerController,
                customControls: SizedBox(),
                aspectRatio: 1,
                // Prepare the video to be played and display the first frame
                autoInitialize: true,
                looping: true,
                autoPlay: true,
                // aspectRatio: 3 / 2,
                // allowFullScreen: true,
                // Errors can occur for example when trying to play a video
                // from a non-existent URL
                errorBuilder: (context, errorMessage) {
                  return Center(
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

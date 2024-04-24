import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoApp2 extends StatefulWidget {
  String assets="";
  VideoApp2({required this.assets});
  @override
  _VideoApp2State createState() => _VideoApp2State(assetsURL: assets);
}

class _VideoApp2State extends State<VideoApp2> {
  String assetsURL="";
  _VideoApp2State({required this.assetsURL});

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(assetsURL)
      ..initialize().then((_) {
        _controller.setVolume(0.0);
        _controller.setLooping(true);
        _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? SizedBox(
        width: MediaQuery.of(context).size.width*1.1,
        height: MediaQuery.of(context).size.height*1.1,
        child: FittedBox(
          fit: BoxFit.cover,
          child: Container(
            width: MediaQuery.of(context).size.width*1.1,
            height: MediaQuery.of(context).size.height*1.1,
            color: Colors.white,
            child: VideoPlayer(_controller),
          ),
        ),
      )
          : Container(),

    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}
class _VideoWidgetState extends State<VideoWidget> {
  late final VideoPlayerController videocontroller;

  @override
  void initState() {
    super.initState();

  Future.delayed(Duration(milliseconds: 2500), () {
    setState(() {
      
    });
     videocontroller = VideoPlayerController.asset('assets/login.mp4')
      ..initialize().then((_) {
        videocontroller.play();
        videocontroller.setLooping(true);
      });
  });
    videocontroller = VideoPlayerController.asset('assets/login.mp4')
      ..initialize().then((_) {
        videocontroller.play();
        videocontroller.setLooping(true);
      });

    
  }

  @override
  Widget build(BuildContext context) => VideoPlayer(videocontroller);
   
}


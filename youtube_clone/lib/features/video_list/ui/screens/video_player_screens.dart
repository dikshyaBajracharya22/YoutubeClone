import 'package:flutter/material.dart';
import 'package:youtube_clone/features/dashboard/model/video.dart';
import 'package:youtube_clone/features/video_list/ui/screens/widgets/video_player_widget.dart';

class VideoPlayerScreens extends StatelessWidget {
  final Video video;
  const VideoPlayerScreens({ Key? key, required this.video }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidgets(
      video: video,
    );
  }
}
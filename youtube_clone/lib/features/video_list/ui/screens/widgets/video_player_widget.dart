import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/features/dashboard/model/video.dart';

import '../../../../../common/constants/theme.dart';

class VideoPlayerWidgets extends StatefulWidget {
  final Video video;
  const VideoPlayerWidgets({Key? key, required this.video}) : super(key: key);

  @override
  State<VideoPlayerWidgets> createState() => _VideoPlayerWidgetsState();
}

class _VideoPlayerWidgetsState extends State<VideoPlayerWidgets> {
  late BetterPlayerController _betterPlayerController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, widget.video.videoUrl);
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.primarycolor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(
              controller: _betterPlayerController,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding:
                EdgeInsets.symmetric(horizontal: CustomTheme.horixontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Type: ${widget.video.type}"),
                Text("Duration: ${widget.video.duration.toString()}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Likes: ${widget.video.likes.toString()}"),
                    Text("Downloads: ${widget.video.downloads.toString()}"),
                    Text("Comments: ${widget.video.comments.toString()}"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

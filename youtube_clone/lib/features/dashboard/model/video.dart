import 'dart:math';

import 'package:youtube_clone/features/dashboard/model/video_list.dart';

class Video {
  final int id;
  final String type;
  final List<String> tags;
  final int duration;
  final int views;
  final int downloads;
  final int likes;
  final int comments;
  final int userId;
  final String user;
  final String userImage;
  final String picture;
  final VideoList videoList;

  Video({
    required this.id,
    required this.type,
    required this.tags,
    required this.duration,
    required this.views,
    required this.comments,
    required this.downloads,
    required this.likes,
    required this.user,
    required this.userId,
    required this.userImage,
    required this.picture,
    required this.videoList,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json["id"], //api ma vako nam
      type: json["type"],
      tags: (json["tags"] ?? "")
          .toString()
          .split(",")
          .map((e) => e.trim()) // spaces haru hataucha trim le
          .toList(), //list ma vako Strings lai , le seperate garcha split ley
      duration: json["duration"],
      views: json["views"],
      comments: json["comments"],
      downloads: json["downloads"],
      likes: json["likes"],
      user: json["user"],
      userId: json["user_id"],
      userImage: json["userImageURL"],
      picture: json["picture_id"],
      videoList: VideoList.fromJson(json["videos"] ?? {}),
    );
  }

  String get picturee {
    return "https://i.vimeocdn.com/video/${picture}_295x166.jpg";
  }

  String get videoName {
    if (tags.isEmpty) {
      return "$user $type";
    } else if (tags.length == 1) {
      return "${tags.first} $type";
    } else {
      final _index = Random().nextInt(tags.length);
      return "${tags[_index]} $user";
    }
  }

  String get videoUrl {
    if (videoList.tiny != null) {
      return videoList.tiny!.url;
    } else if (videoList.small != null) {
      return videoList.small!.url;
    } else if (videoList.medium != null) {
      return videoList.medium!.url;
    } else if (videoList.large != null) {
      return videoList.large!.url;
    }else{
      return "";
    }
  }
}

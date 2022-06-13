// "large": {
//                 "url": "https://player.vimeo.com/external/135736646.hd.mp4?s=ed02d71c92dd0df7d1110045e6eb65a6&profile_id=119",
//                 "width": 1920,
//                 "height": 1080,
//                 "size": 6615235
//             },
//             "medium": {
//                 "url": "https://player.vimeo.com/external/135736646.hd.mp4?s=ed02d71c92dd0df7d1110045e6eb65a6&profile_id=174",
//                 "width": 1280,
//                 "height": 720,
//                 "size": 3562083
//             },
//             "small": {
//                 "url": "https://player.vimeo.com/external/135736646.sd.mp4?s=db2924c48ef91f17fc05da74603d5f89&profile_id=165",
//                 "width": 950,
//                 "height": 540,
//                 "size": 2030736
//             },
//             "tiny": {
//                 "url": "https://player.vimeo.com/external/135736646.sd.mp4?s=db2924c48ef91f17fc05da74603d5f89&profile_id=164",
//                 "width": 640,
//                 "height": 360,
//                 "size": 1030736
//             }

import 'package:youtube_clone/features/dashboard/model/single_video.dart';

class VideoList{
 final SingleVideo? large;
 final SingleVideo? medium;
 final SingleVideo? small;
 final SingleVideo? tiny;

  VideoList({this.large, this.medium, this.small, this.tiny});

  factory VideoList.fromJson(Map<String, dynamic> json){
    return VideoList(
      tiny: json["tiny"] !=null ? SingleVideo.fromJson(json["tiny"]) : null,
      small: json["small"] !=null ? SingleVideo.fromJson(json["small"]) : null,
      medium: json["medium"] !=null ? SingleVideo.fromJson(json["medium"]) : null,
      large: json["large"] !=null ? SingleVideo.fromJson(json["large"]) : null,

    );

  }
}
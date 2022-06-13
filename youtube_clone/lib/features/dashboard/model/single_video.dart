

class SingleVideo {
  final String url;
  final int width;
  final int height;
  final int size;

  SingleVideo({
    required this.url,
    required this.width,
    required this.height,
    required this.size,
  });
  factory SingleVideo.fromJson(Map<String, dynamic> json) {
    return SingleVideo(
        url: json["url"],
        width: json["width"],
        height: json["height"],
        size: json["size"]);
  }
}

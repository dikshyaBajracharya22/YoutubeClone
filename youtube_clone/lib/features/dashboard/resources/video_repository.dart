import 'package:dio/dio.dart';
import 'package:youtube_clone/common/constants/constants.dart';
import 'package:youtube_clone/common/model/data_response.dart';
import 'package:youtube_clone/features/dashboard/model/video.dart';

class VideoRepository {
  final _dio = Dio();
  final List<Video> _videos = [];
  List<Video> get videos => _videos;

  int _totalItems = -1;
  int _currentPage = 1;

  String _lastSearchQuery = "";

  String _lastOrders = "";
  String _lastVideoType = "";

  Future<DataResponse> fetchVideos(
      {bool isLoadMore = false,
      String query = "",
      String orders = "",
      String videoType = ""}) async {
    try {
      if (_videos.length == _totalItems &&
          _lastSearchQuery == query &&
          _lastOrders == orders &&
          _lastVideoType == videoType) {
        return DataResponse.success(data: _videos);
      }
      if (isLoadMore) {
        _currentPage++;
      } else {
        _currentPage = 1;
        _lastSearchQuery = query;
        _lastOrders = orders;
        _lastSearchQuery = videoType;

      }
      final _res = await _dio.get(
          "https://pixabay.com/api/videos/?key=${Constants.apiKey}&page=$_currentPage&q=$_lastSearchQuery&video_type=$videoType&order=$orders");
      final List<Video> _hits = List.from(_res.data["hits"] ?? [])
          .map((e) => Video.fromJson(e))
          .toList();

      _totalItems = _res.data["totalHits"];

      if (isLoadMore == false) {
        _videos.clear();
      }
      videos
          .addAll(_hits); // api ma hits ma vako sab data videos ma gayera basyo
      return DataResponse.success(
          data:
              _videos); //succes huda status true huncha from dataresposne.dart
    } catch (e) {
      return DataResponse.error(message: e.toString());
    }
  }
}

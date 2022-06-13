import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/common/cubits/common_state.dart';
import 'package:youtube_clone/features/dashboard/model/video.dart';
import 'package:youtube_clone/features/dashboard/resources/video_repository.dart';

class VideoCubit extends Cubit<CommonState> {
  VideoCubit({required this.videoRepository}) : super(CommonInitialState());

  final VideoRepository videoRepository;

   

  fetchVideos({String query ="", String orders="", String videoType=""}) async{
    emit(CommonLoadingState());
    final _res= await videoRepository.fetchVideos(query: query, orders: orders, videoType: videoType);
    if(_res.status){ //DataResponse.success huda status true hucnha from videorepository.dart
      emit(CommonDataFetchedState<Video>(items: _res.data));//data pani
    }else{// Dataresponse.error huda status false huncha
      emit(CommonErrorState(message: _res.message));
    }
  }
    refreshVideos({String query ="", String orders="", String videoType=""}) async{
    emit(CommonDummyLoadingState());
    final _res= await videoRepository.fetchVideos(query: query, orders: orders, videoType: videoType);
    if(_res.status){ //DataResponse.success huda status true hucnha from videorepository.dart
      emit(CommonDataFetchedState<Video>(items: _res.data));//data pani
    }else{// Dataresponse.error huda status false huncha
      emit(CommonErrorState(message: _res.message));
    }
  }
  loadMoreVideos({String query ="",  String orders="", String videoType=""}) async{
    emit(CommonDummyLoadingState());
    final _res= await videoRepository.fetchVideos(isLoadMore: true, query: query,  orders: orders, videoType: videoType);
    if(_res.status){ //DataResponse.success huda status true hucnha from videorepository.dart
      emit(CommonDataFetchedState<Video>(items: _res.data));//data pani
    }else{// Dataresponse.error huda status false huncha
      emit(CommonErrorState(message: _res.message));
    }
  }
}
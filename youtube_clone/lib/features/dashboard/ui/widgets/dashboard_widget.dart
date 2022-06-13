import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youtube_clone/common/constants/theme.dart';
import 'package:youtube_clone/common/cubits/common_state.dart';
import 'package:youtube_clone/common/widgets/text_fields/custom_textfield.dart';
import 'package:youtube_clone/features/dashboard/cubit/video_cubit.dart';
import 'package:youtube_clone/features/dashboard/model/video.dart';
import 'package:youtube_clone/features/dashboard/ui/widgets/filter_widget.dart';
import 'package:youtube_clone/features/dashboard/ui/widgets/logout_dialogbox.dart';
import 'package:youtube_clone/features/onboarding/widgets/video_card.dart';
import 'package:youtube_clone/features/video_list/ui/screens/video_player_screens.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final _refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();

  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = false;
  final ValueNotifier<String> _orders=ValueNotifier("");

  final ValueNotifier<String> _videoTypes=ValueNotifier("");


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // BlocProvider.of<VideoCubit>(context).fetchVideos(); //same thing
    context.read<VideoCubit>().fetchVideos();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.1,
          backgroundColor: CustomTheme.lightGrey,
          title: Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: "Search Videos",
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      onSubmit: (){
                         context.read<VideoCubit>().fetchVideos(query: _searchController.text, 
                         orders: _orders.value,
                         videoType: _videoTypes.value);
                      },
                      
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: IconButton(
                      onPressed: () {
                       
                        context.read<VideoCubit>().fetchVideos(query: _searchController.text,
                         orders: _orders.value,
                         videoType: _videoTypes.value);
                      },
                      icon: Icon(Icons.search),
                      color: CustomTheme.primarycolor,
                    ),
                  ),
                  //Animation
                  OpenContainer(
                    closedColor: Colors.transparent,
                    closedElevation: 0,
                    closedBuilder: (context, open){
                    return  Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: IconButton(
                      onPressed: open,
                      icon: Icon(Icons.filter_list_rounded),
                      color: CustomTheme.primarycolor,
                    ),
                  );
                  }, openBuilder: (context, close){
                    return FilterWidget(
                      orders: _orders,
                      videoTypes: _videoTypes,
                      onApply: (order, videoType){
                        context.read<VideoCubit>().fetchVideos(
                          query: _searchController.text,
                          orders: order,
                          videoType: videoType,
                        );
                      },
                    );
                  }),
                   Container(
                    padding: EdgeInsets.only(bottom: 15),
                     child: IconButton(
                        onPressed: (){
                          showLogoutDialogBox(context);
                        },
                        icon: Icon(Icons.logout),
                        color: CustomTheme.primarycolor,
                      ),
                   ),
                  
                ],
              ))),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollnotification) {
          if (scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
            if (scrollnotification.metrics.pixels >
                    (scrollnotification.metrics.maxScrollExtent / 2) &&
                _isLoading == false) {
              _isLoading = true;
              context.read<VideoCubit>().loadMoreVideos(query: _searchController.text,
               orders: _orders.value,
                         videoType: _videoTypes.value);
            }
          }
          return true;
        },
        child: Container(
            child: BlocConsumer<VideoCubit, CommonState>(
          buildWhen: (context, state) {
            if (state is CommonDummyLoadingState) {
              return false;
            } else {
              return true;
            }
          },
          listener: (context, state) {
            if (state is! CommonDummyLoadingState &&
                state is! CommonLoadingState) {
              _isLoading = false;
              _refreshController.refreshCompleted();
            }
          },
          builder: (context, state) {
            if (state is CommonDataFetchedState<Video>) {
              return SmartRefresher(
                controller: _refreshController,
                
                onRefresh: () {
                  context.read<VideoCubit>().refreshVideos(query: _searchController.text,  orders: _orders.value,
                         videoType: _videoTypes.value);
                },
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      return VideoCard(
                        imageUrl: state.items[index].picturee,
                        title: state.items[index].videoName,
                        onPressed: () {
                          Navigator.of(context).push(PageTransition(
                              child: VideoPlayerScreens(
                                video: state.items[index],
                              ),
                              type: PageTransitionType.fade));
                        },
                      );
                    }),
              );
            } else if (state is CommonLoadingState) {
              return CupertinoActivityIndicator();
            } else if (state is CommonErrorState) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        )),
      ),
    );
  }
}

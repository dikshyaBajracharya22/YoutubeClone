import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/common/constants/assets.dart';
import 'package:youtube_clone/common/constants/theme.dart';

class VideoCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Function()? onPressed;


  const VideoCard({Key? key, required this.imageUrl, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return Container(
      margin: EdgeInsets.only(
          bottom: 10,
          left: CustomTheme.horixontalPadding,
          right: CustomTheme.horixontalPadding,
          top: 10),
      child: InkWell(
        onTap: onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffF5F5F5),
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) => Image.asset(
                        Assets.placeholder,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        Assets.placeholder,
                        fit: BoxFit.cover,
                      ),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                        child: Container(
                          alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ))
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 10,
                  ),
                  child: Text(
                    title,
                    style: _textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

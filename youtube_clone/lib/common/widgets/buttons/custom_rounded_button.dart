import 'package:flutter/material.dart';
import 'package:youtube_clone/common/constants/theme.dart';

class CustomRoundedButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final double? width;

  const CustomRoundedButton({Key? key, required this.title, this.onPressed, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),

      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: CustomTheme.primarycolor,
          borderRadius: BorderRadius.circular(12),
          
        ),
        child: Text(
          title,
          style: _textTheme.headline6!.copyWith(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

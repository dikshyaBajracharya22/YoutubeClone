import 'package:flutter/material.dart';
import 'package:youtube_clone/common/constants/theme.dart';

class SelectableButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function()? onPressed;
  final double rightMargin;

  const SelectableButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      required this.isSelected,
      this.rightMargin = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
     margin: EdgeInsets.only(right: rightMargin),
      child: Material(

        color: isSelected ? CustomTheme.primarycolor : Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? CustomTheme.primarycolor : CustomTheme.grayColor,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: _textTheme.bodyText1!.copyWith(
                color: isSelected ? Colors.white : CustomTheme.grayColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

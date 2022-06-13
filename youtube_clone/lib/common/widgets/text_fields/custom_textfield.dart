import 'package:flutter/material.dart';
import 'package:youtube_clone/common/constants/theme.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final Function()? onChanged;
  final TextEditingController? controller;
  final String hintText;
  final bool obscure;
  final double bottomMargin;
  final TextInputAction? textInputAction;
  final Function()? onSubmit;
  final String? Function(String?)? validator;

  const CustomTextField(
      {Key? key,
      this.title = "",
      this.onChanged,
      this.controller,
      required this.hintText,
      this.bottomMargin = 20,
      this.obscure = false,
      this.validator,
      this.textInputAction,
      this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return Container(
      padding: EdgeInsets.only(bottom: bottomMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: _textTheme.bodyText2!.copyWith(
                  fontSize: 16,
                  letterSpacing: 0.35,
                  color: CustomTheme.textColor,
                  fontWeight: FontWeight.w700),
            ),
          if (title.isNotEmpty)
            SizedBox(
              height: 8,
            ),
          TextFormField(
            style: _textTheme.headline6!.copyWith(fontSize: 16),
            controller: controller,
            obscureText: obscure,
            validator: validator,
            textInputAction: textInputAction,
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              if (onSubmit != null) {
                onSubmit!();
              }
            },
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              border: _border,
              errorBorder: _border,
              enabledBorder: _border,
              focusedBorder: _border,
              disabledBorder: _border,
              focusedErrorBorder: _border,
              hintText: hintText,
              hintStyle: _textTheme.headline4!
                  .copyWith(color: CustomTheme.grayColor, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  InputBorder get _border {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: CustomTheme.grayColor, width: 1));
  }
}

import 'package:flutter_movie_app/core/themes/app_colors.dart';
import 'package:flutter_movie_app/core/utils/images/app_icons.dart';
import 'package:flutter_movie_app/core/widgets/my_icon.dart';
import 'package:flutter_movie_app/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';

class TextWithPoint extends StatelessWidget {
  final String text;

  const TextWithPoint({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyIcon(
          icon: AppIcons.tileUnselected,
          color: AppColors.blue3,
          padding: EdgeInsets.symmetric(horizontal: 5),
          size: 15,
        ),
        Expanded(
          child: MyText(
            text: text,
            color: AppColors.gray,
          ),
        ),
      ],
    );
  }
}

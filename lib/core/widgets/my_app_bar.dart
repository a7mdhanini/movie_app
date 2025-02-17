import 'package:flutter_movie_app/core/themes/app_colors.dart';
import 'package:flutter_movie_app/core/utils/images/app_icons.dart';
import 'package:flutter_movie_app/core/widgets/my_icon.dart';
import 'package:flutter_movie_app/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget myAppBar(
  BuildContext context, {
  String title = '',
  bool isBack = true,
  List<Widget>? actions,
  bool removeLeading = false,
}) {
  return AppBar(
    backgroundColor: AppColors.darkBlue,
    leadingWidth: 80,
    scrolledUnderElevation: 0.0,

    ///---------------------------------///
    ///----Leading Notification Icon----///
    ///---------------------------------///
    leading: Visibility(
      visible: !removeLeading,
      child: Visibility(
        visible: isBack,
        child: MyIcon(
          withDecoration: true,
          icon: AppIcons.arrowBack,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    ),

    ///-------------///
    ///----Title----///
    ///-------------///
    centerTitle: true,
    title: MyText(
      text: title,
      fontSize: 20,
      color: AppColors.white,
    ),

    ///---------------///
    ///----Actions----///
    ///---------------///
    actions: actions ??
        [
          ///-------------------///
          ///----Search Icon----///
          ///-------------------///
          MyIcon(
            icon: AppIcons.search,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            onTap: () {},
          ),
        ],
  );
}

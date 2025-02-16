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
    backgroundColor: AppColors.background,
    leadingWidth: 80,
    scrolledUnderElevation: 0.0,

    ///---------------------------------///
    ///----Leading Notification Icon----///
    ///---------------------------------///
    leading: Visibility(
      visible: !removeLeading,
      child: Visibility(
        visible: isBack,
        replacement: MyIcon(
          icon: AppIcons.notificationOn, //AppIcons.notificationoff for off
          padding: const EdgeInsets.symmetric(horizontal: 15),
          onTap: () {
            // Route route = MaterialPageRoute(
            //   builder: (context) => NotificationsScreen(),
            // );
            // Navigator.push(context, route);
          },
        ),
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
      color: AppColors.gray,
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
            onTap: () {
              // Route route = MaterialPageRoute(
              //   builder: (context) => SearchScreen(),
              // );
              // Navigator.push(context, route);
            },
          ),
        ],
  );
}

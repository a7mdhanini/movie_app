import 'package:flutter/material.dart';
import 'package:flutter_movie_app/core/apis/api_base.dart';
import 'package:flutter_movie_app/core/utils/app_sizes.dart';
import 'package:flutter_movie_app/core/widgets/my_image.dart';
import 'package:flutter_movie_app/core/widgets/texts/my_text.dart';

class MovieTvItem extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final String overview;
  final String posterPath;

  const MovieTvItem({
    required this.onTap,
    required this.title,
    required this.overview,
    required this.posterPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: MyImage(
          width: Sizes.width / 8,
          fit: BoxFit.contain,
          image: Environment.baseImageUrl + posterPath,
        ),
        title: MyText(
          text: title,
          color: Colors.white,
          type: TextType.semiMedium,
        ),
        subtitle: MyText(
          text: overview,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          color: Colors.grey,
        ),
      ),
    );
  }
}

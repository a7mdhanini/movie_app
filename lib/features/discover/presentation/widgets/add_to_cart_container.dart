import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:like_button/like_button.dart';

class FavoriteRateContainer extends StatelessWidget {
  final Function(bool)? onTapFavorite;
  final void Function(double) onRatingUpdate;

  const FavoriteRateContainer({
    required this.onTapFavorite,
    required this.onRatingUpdate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.black38,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///----Favorite Button----///
              LikeButton(
                padding: const EdgeInsets.all(10),
                onTap: (isLiked) async {
                  await onTapFavorite!(isLiked);
                  return !isLiked;
                },
              ),

              const SizedBox(width: 10),

              ///----Rate Button----///
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                unratedColor: Colors.amber.withAlpha(50),
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: onRatingUpdate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

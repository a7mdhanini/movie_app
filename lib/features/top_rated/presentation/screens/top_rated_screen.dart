import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_movie_app/core/themes/app_colors.dart';
import 'package:flutter_movie_app/core/utils/app_sizes.dart';
import 'package:flutter_movie_app/core/utils/images/app_icons.dart';
import 'package:flutter_movie_app/core/widgets/buttons/my_button.dart';
import 'package:flutter_movie_app/core/widgets/card_container.dart';
import 'package:flutter_movie_app/core/widgets/my_app_bar.dart';
import 'package:flutter_movie_app/core/widgets/my_background.dart';
import 'package:flutter_movie_app/features/cards/bloc/cards_bloc.dart';
import 'package:flutter_movie_app/features/cards/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/features/cards/repository/card_repository.dart';

class TopRatedScreen extends StatelessWidget {
  const TopRatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardsBloc(context, repository: CardRepository())
        ..add(CardsLoadingEvent()),
      child: Scaffold(
        ///---------------///
        ///----App Bar----///
        ///---------------///
        appBar: myAppBar(context, title: 'Top Rated'),

        ///------------///
        ///----Body----///
        ///------------///
        body: BlocBuilder<CardsBloc, CardsStateAbstract>(
          builder: (context, state) {
            CardsBloc bloc = context.read<CardsBloc>();
            if (state is CardsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CardsEmptyState) {
              return const Center(child: Text('No Cards'));
            }
            if (state is CardsErrorState) {
              return Center(
                  child:
                      Text('holy shit an error +${state.message.toString()}'));
            } else {
              return MyBackground(
                child: Column(
                  children: [
                    SizedBox(
                      width: Sizes.width,
                      height: Sizes.height / 3.5,
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                          initialPage: 0,
                          enlargeFactor: 0.1,
                          onPageChanged: (index, reason) {
                            bloc.add(UpdateCardIndexEvent(index));
                          },
                        ),
                        itemCount: bloc.cardsList.length,
                        itemBuilder: (context, index, pageViewIndex) {
                          final card = bloc.cardsList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CardContainer(
                              width: Sizes.width,
                              cardTypeName: card.cardType,
                              cardNumber: card.cardNumber,
                              cardExpirationDate: card.expirationDate,
                              onTap: bloc.currentIndex == pageViewIndex
                                  ? () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         ShowCardScreen(card: card),
                                      //   ),
                                      // );
                                    }
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    // Add New Card Button
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(15),
                      color: AppColors.tertiary,
                      dashPattern: const [10],
                      child: Container(
                        width: Sizes.width / 1.1,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: MyButton(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 70,
                            vertical: 40,
                          ),
                          title: 'Add a new card',
                          icon: AppIcons.plus2,
                          borderColor: AppColors.tertiary,
                          color: AppColors.lightGray.withOpacity(0.5),
                          onPressed: () {
                            // Show add card dialog/screen and handle the result
                            // Example:
                            final newCard = CardModel(
                              id: 1,
                              cardNumber: '**** **** **** 1234',
                              cardType: 'VISA',
                              expirationDate: '12/25',
                            );
                            bloc.add(AddNewCardEvent(newCard));
                            // context.read<CardsBloc>().add(AddNewCard(newCard));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

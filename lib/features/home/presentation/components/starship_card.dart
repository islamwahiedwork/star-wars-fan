import 'package:flutter/material.dart';
import 'package:star_wars_app/core/utils/app_string.dart';
import 'package:star_wars_app/features/home/data/model/favourite_model.dart';
import 'package:star_wars_app/features/home/data/model/starship_model.dart';
import 'package:star_wars_app/features/home/presentation/controller/home_cubit.dart';
import 'high_light_text/high_light_text.dart';

class StarshipCard extends StatelessWidget {
  final Starship starship;

  const StarshipCard({
    super.key,
    required this.starship,
  });

  @override
  Widget build(BuildContext context) {
    bool isFavorite = HomeCubit.get(context).listFavorites.any((element) =>
        element.itemId == starship.name &&
        element.sectionName == AppString.starships);
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HighlightedTextWidgetForHeader(
                  text: starship.name,
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    HomeCubit.get(context).addToFavorites(
                        favourite: Favourite(
                            sectionName: AppString.starships,
                            itemId: starship.name));
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            HighlightedTextWidget(titleText: 'Model: ', text: starship.model),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Manufacturer: ', text: starship.manufacturer),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Cost in Credits: ', text: starship.costInCredits),
            const SizedBox(height: 4),
            HighlightedTextWidget(titleText: 'Length: ', text: starship.length),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Max Atmospheric Speed: ',
                text: starship.maxAtmospheringSpeed),
            const SizedBox(height: 4),
            HighlightedTextWidget(titleText: 'Crew: ', text: starship.crew),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Passengers: ', text: starship.passengers),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Cargo Capacity: ', text: starship.cargoCapacity),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Consumables: ', text: starship.consumables),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Hyper drive Rating: ',
                text: starship.hyperdriveRating),
            const SizedBox(height: 4),
            HighlightedTextWidget(titleText: 'MGLT: ', text: starship.MGLT),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Starship Class: ', text: starship.starshipClass),
          ],
        ),
      ),
    );
  }
}

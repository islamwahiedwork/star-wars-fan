import 'package:flutter/material.dart';
import 'package:star_wars_app/core/utils/app_string.dart';
import 'package:star_wars_app/features/home/data/model/favourite_model.dart';
import 'package:star_wars_app/features/home/data/model/species_model.dart';
import 'package:star_wars_app/features/home/presentation/components/high_light_text/high_light_text.dart';
import 'package:star_wars_app/features/home/presentation/controller/home_cubit.dart';

class SpeciesCard extends StatelessWidget {
  final Species species;

  const SpeciesCard({
    super.key,
    required this.species,
  });

  @override
  Widget build(BuildContext context) {
    bool isFavorite = HomeCubit.get(context).listFavorites.any((element) =>
        element.itemId == species.name &&
        element.sectionName == AppString.species);
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
                  text: species.name,
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    HomeCubit.get(context).addToFavorites(
                        favourite: Favourite(
                            sectionName: AppString.species,
                            itemId: species.name));
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            HighlightedTextWidget(
                titleText: 'Classification: ', text: species.classification),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Designation: ', text: species.designation),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Average Height: ', text: species.averageHeight),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Skin Colors: ', text: species.skinColors),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Hair Colors: ', text: species.hairColors),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Eye Colors: ', text: species.eyeColors),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Average Lifespan: ', text: species.averageLifespan),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Home world: ', text: species.homeworld),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Language: ', text: species.language),
          ],
        ),
      ),
    );
  }
}

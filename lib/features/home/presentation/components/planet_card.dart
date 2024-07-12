import 'package:flutter/material.dart';
import 'package:star_wars_app/core/utils/app_string.dart';
import 'package:star_wars_app/features/home/data/model/favourite_model.dart';
import 'package:star_wars_app/features/home/data/model/planet_model.dart';
import 'package:star_wars_app/features/home/presentation/components/high_light_text/high_light_text.dart';
import 'package:star_wars_app/features/home/presentation/controller/home_cubit.dart';

class PlanetCard extends StatelessWidget {
  final Planet planet;

  const PlanetCard({
    super.key,
    required this.planet,
  });

  @override
  Widget build(BuildContext context) {
    bool isFavorite = HomeCubit.get(context).listFavorites.any((element) =>
        element.itemId == planet.name &&
        element.sectionName == AppString.planets);
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
                  text: planet.name,
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    HomeCubit.get(context).addToFavorites(
                        favourite: Favourite(
                            sectionName: AppString.planets,
                            itemId: planet.name));
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            HighlightedTextWidget(
                titleText: 'Rotation Period: ', text: planet.rotationPeriod),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Orbital Period: ', text: planet.orbitalPeriod),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Diameter: ', text: planet.diameter),
            const SizedBox(height: 4),
            HighlightedTextWidget(titleText: 'Climate: ', text: planet.climate),
            const SizedBox(height: 4),
            HighlightedTextWidget(titleText: 'Gravity: ', text: planet.gravity),
            const SizedBox(height: 4),
            HighlightedTextWidget(titleText: 'Terrain: ', text: planet.terrain),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Surface Water: ', text: planet.surfaceWater),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Population: ', text: planet.population),
          ],
        ),
      ),
    );
  }
}

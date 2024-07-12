import 'package:flutter/material.dart';
import 'package:star_wars_app/core/utils/app_string.dart';
import 'package:star_wars_app/features/home/data/model/favourite_model.dart';
import 'package:star_wars_app/features/home/data/model/film_model.dart';
import 'package:star_wars_app/features/home/presentation/controller/home_cubit.dart';

import 'high_light_text/high_light_text.dart';

class FilmCard extends StatelessWidget {
  final Film film;

  const FilmCard({
    super.key,
    required this.film,
  });

  @override
  Widget build(BuildContext context) {
    bool isFavorite = HomeCubit.get(context).listFavorites.any((element) =>
        element.itemId == film.episodeId.toString() &&
        element.sectionName == AppString.films);
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
                  text: film.title,
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    HomeCubit.get(context).addToFavorites(
                        favourite: Favourite(
                            sectionName: AppString.films,
                            itemId: film.episodeId.toString()));
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            HighlightedTextWidget(titleText: 'Director: ', text: film.director),
            const SizedBox(height: 4),
            HighlightedTextWidget(titleText: 'Producer: ', text: film.producer),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Release Date: ', text: film.releaseDate.toString()),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Opening Crawl: ', text: film.openingCrawl),
          ],
        ),
      ),
    );
  }
}

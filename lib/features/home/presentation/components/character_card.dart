import 'package:flutter/material.dart';
import 'package:star_wars_app/core/utils/app_string.dart';
import 'package:star_wars_app/features/home/data/model/favourite_model.dart';
import 'package:star_wars_app/features/home/data/model/people_model.dart';
import 'package:star_wars_app/features/home/presentation/controller/home_cubit.dart';
import 'high_light_text/high_light_text.dart';


class CharacterCard extends StatelessWidget {
  final StarWarsCharacter character;

  const CharacterCard({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    bool isFavorite = HomeCubit.get(context).listFavorites.any((element) =>
    element.itemId == character.name && element.sectionName == AppString.character);
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
                HighlightedTextWidgetForHeader(text:
                  character.name,

                ),
                IconButton(
                  icon:   Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    HomeCubit.get(context).addToFavorites(favourite: Favourite(sectionName: AppString.character, itemId:character.name));
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            HighlightedTextWidget(titleText:'Height:' ,text:character.height),
            const SizedBox(height: 4),
            HighlightedTextWidget(titleText:'Mass: ',text:character.mass),
            const SizedBox(height: 4),
            HighlightedTextWidget(titleText:'Hair Color: ',text:character.hairColor),
            const SizedBox(height: 4),
            HighlightedTextWidget(titleText:'Skin Color: ',text:character.skinColor),
            const SizedBox(height: 4),
            HighlightedTextWidget(titleText:'Eye Color: ',text:character.eyeColor),
            const SizedBox(height: 4),
            HighlightedTextWidget(titleText:'Birth Year: ',text:character.birthYear),
            const SizedBox(height: 4),
            HighlightedTextWidget(titleText:'Gender: ',text:character.gender),
          ],
        ),
      ),
    );
  }
}
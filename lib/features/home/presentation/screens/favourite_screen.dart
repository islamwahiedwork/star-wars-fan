import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/core/utils/app_string.dart';
import 'package:star_wars_app/features/home/presentation/components/build_animated_list.dart';
import 'package:star_wars_app/features/home/presentation/components/character_card.dart';
import 'package:star_wars_app/features/home/presentation/components/film_card.dart';
import 'package:star_wars_app/features/home/presentation/components/nodata_message.dart';
import 'package:star_wars_app/features/home/presentation/components/planet_card.dart';
import 'package:star_wars_app/features/home/presentation/components/species_card.dart';
import 'package:star_wars_app/features/home/presentation/components/starship_card.dart';
import 'package:star_wars_app/features/home/presentation/components/vehicle_card.dart';
import 'package:star_wars_app/features/home/presentation/controller/home_cubit.dart';
import 'package:star_wars_app/features/home/presentation/controller/home_state.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            // Disable swipe to change tabs
            children: [
              buildCategoryTab(context, AppString.character),
              buildCategoryTab(context, AppString.planets),
              buildCategoryTab(context, AppString.films),
              buildCategoryTab(context, AppString.species),
              buildCategoryTab(context, AppString.vehicles),
              buildCategoryTab(context, AppString.starships),
            ],
          ),
        );
      },
    );
  }

  Widget buildCategoryTab(BuildContext context, String category) {
    final homeCubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // Add listeners if needed
      },
      builder: (context, state) {
        if (category == AppString.character &&
            homeCubit.listStarWarsCharacter != [] &&
            homeCubit.listStarWarsCharacter.isNotEmpty) {
          var listStarWarsCharacterFavorite = homeCubit.listStarWarsCharacter
              .where((character) => homeCubit.listFavorites.any((favorite) =>
                  favorite.sectionName == AppString.character &&
                  favorite.itemId == character.name))
              .toList();

          return listStarWarsCharacterFavorite.isNotEmpty
              ? buildAnimatedList(context, listStarWarsCharacterFavorite,
                  (character) => CharacterCard(character: character))
              : const CenteredMessage(
                  message: AppString.noFavorites,
                );
        } else if (category == AppString.planets &&
            homeCubit.listPlanets.isNotEmpty) {
          var listPlanetsFavorite = homeCubit.listPlanets
              .where((planet) => homeCubit.listFavorites.any((favorite) =>
                  favorite.sectionName == AppString.planets &&
                  favorite.itemId == planet.name))
              .toList();

          return listPlanetsFavorite.isNotEmpty
              ? buildAnimatedList(context, listPlanetsFavorite,
                  (planet) => PlanetCard(planet: planet))
              : const CenteredMessage(
                  message: AppString.noFavorites,
                );
        } else if (category == AppString.films &&
            homeCubit.listFilms.isNotEmpty) {
          var listPlanetsFavorite = homeCubit.listFilms
              .where((film) => homeCubit.listFavorites.any((favorite) =>
                  favorite.sectionName == AppString.films &&
                  favorite.itemId == film.episodeId.toString()))
              .toList();

          return listPlanetsFavorite.isNotEmpty
              ? buildAnimatedList(
                  context, listPlanetsFavorite, (film) => FilmCard(film: film))
              : const CenteredMessage(
                  message: AppString.noFavorites,
                );
        } else if (category == AppString.species &&
            homeCubit.listSpecies.isNotEmpty) {
          var listSpeciesFavorite = homeCubit.listSpecies
              .where((species) => homeCubit.listFavorites.any((favorite) =>
                  favorite.sectionName == AppString.species &&
                  favorite.itemId == species.name.toString()))
              .toList();

          return listSpeciesFavorite.isNotEmpty
              ? buildAnimatedList(context, listSpeciesFavorite,
                  (species) => SpeciesCard(species: species))
              : const CenteredMessage(
                  message: AppString.noFavorites,
                );
        } else if (category == AppString.vehicles &&
            homeCubit.listVehicles.isNotEmpty) {
          var listVehiclesFavorite = homeCubit.listVehicles
              .where((vehicles) => homeCubit.listFavorites.any((favorite) =>
                  favorite.sectionName == AppString.vehicles &&
                  favorite.itemId == vehicles.name.toString()))
              .toList();

          return listVehiclesFavorite.isNotEmpty
              ? buildAnimatedList(context, listVehiclesFavorite,
                  (vehicle) => VehicleCard(vehicle: vehicle))
              : const CenteredMessage(
                  message: AppString.noFavorites,
                );
        } else if (category == AppString.starships &&
            homeCubit.listStarships.isNotEmpty) {
          var listStarshipsFavorite = homeCubit.listStarships
              .where((starships) => homeCubit.listFavorites.any((favorite) =>
                  favorite.sectionName == AppString.starships &&
                  favorite.itemId == starships.name.toString()))
              .toList();
          return listStarshipsFavorite.isNotEmpty
              ? buildAnimatedList(context, listStarshipsFavorite,
                  (starship) => StarshipCard(starship: starship))
              : const CenteredMessage(
                  message: AppString.noFavorites,
                );
        } else {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppString.noDataAvailable,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/core/utils/app_string.dart';
import 'package:star_wars_app/core/utils/global.dart';
import 'package:star_wars_app/features/home/presentation/components/build_animated_list.dart';
import 'package:star_wars_app/features/home/presentation/components/character_card.dart';
import 'package:star_wars_app/features/home/presentation/components/film_card.dart';
import 'package:star_wars_app/features/home/presentation/components/planet_card.dart';
import 'package:star_wars_app/features/home/presentation/components/search_box/search_box.dart';
import 'package:star_wars_app/features/home/presentation/components/species_card.dart';
import 'package:star_wars_app/features/home/presentation/components/starship_card.dart';
import 'package:star_wars_app/features/home/presentation/components/vehicle_card.dart';
import 'package:star_wars_app/features/home/presentation/controller/home_cubit.dart';
import 'package:star_wars_app/features/home/presentation/controller/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return Stack(
          alignment: Alignment.center,
          children: [
            Scaffold(
              extendBody: true,
              body: Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SearchBox(txtSearchController: Global.txtSearchController,
                      onChanged: (String value ) {
                      homeCubit.getSearchResults();
                    },),
                  ),
                  Padding(
                    padding: const EdgeInsets.only( right: 20,top : 20,left: 20,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Results'),
                        Text('(${homeCubit.searchResultsCount.toString()})', style: const TextStyle(color: Colors.blue),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          SliverOverlapAbsorber(
                            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                                context),
                            sliver: SliverAppBar(
                              automaticallyImplyLeading: false,
                              expandedHeight: 150.0,
                              flexibleSpace: FlexibleSpaceBar(
                                background:homeCubit.searchResultsCount > 0 ? Image.asset(
                                  homeCubit.currentTabIndex == 0
                                      ? AppString.coverImage
                                      : homeCubit.currentTabIndex == 1
                                          ? AppString.planetsImage
                                          : homeCubit.currentTabIndex == 2
                                              ? AppString.filmsImage
                                              : homeCubit.currentTabIndex == 3
                                                  ? AppString.speciesImage
                                                  : homeCubit.currentTabIndex == 4
                                                      ? AppString.vehiclesImage
                                                      : AppString.starshipsImage,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ) : null,
                              ),
                            ),
                          ),
                        ];
                      },
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
                    ),
                  ),
                ],
              ),
            ),
            if (Global.isListening)
              const Positioned(

                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 50,
                  child: Icon(
                    Icons.mic,
                    color: Colors.red,
                    size: 50.0,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget buildCategoryTab(BuildContext context, String category) {
    final homeCubit = HomeCubit.get(context);

    Future<void> refreshData() async {
      try{
        Global.txtSearchController.clear();
      }catch (e){
        print(e);
      }

      switch (category) {
        case AppString.character:
          homeCubit
              .getStarWarsPeople(); // Adjust this method call based on your implementation
          break;
        case AppString.planets:
          homeCubit
              .getStarWarsPlanets(); // Adjust this method call based on your implementation
          break;
        case AppString.films:
          homeCubit
              .getStarWarsFilms(); // Adjust this method call based on your implementation
          break;
        case AppString.species:
          homeCubit
              .getStarWarsSpecies(); // Adjust this method call based on your implementation
          break;
        case AppString.vehicles:
          homeCubit
              .getStarWarsVehicles(); // Adjust this method call based on your implementation
          break;
        case AppString.starships:
          homeCubit
              .getStarWarsStarships(); // Adjust this method call based on your implementation
          break;
      }


    }

    return RefreshIndicator(
      onRefresh: refreshData,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // Add listeners if needed
        },
        builder: (context, state) {
          if (state is GetPeopleLoadingState ||
              state is GetPlanetsLoadingState ||
              state is GetFilmsLoadingState ||
              state is GetSpeciesLoadingState ||
              state is GetVehiclesLoadingState ||
              state is GetStarsShipsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (category == AppString.character &&
              homeCubit.listStarWarsCharacter.isNotEmpty) {
            homeCubit.searchResultsCount = homeCubit.listStarWarsCharacter.length;
            return buildAnimatedList(context, homeCubit.listStarWarsCharacter,
                (character) => CharacterCard(character: character));
          } else if (category == AppString.planets &&
              homeCubit.listPlanets.isNotEmpty) {
            homeCubit.searchResultsCount = homeCubit.listPlanets.length;
            return buildAnimatedList(context, homeCubit.listPlanets,
                (planet) => PlanetCard(planet: planet));
          } else if (category == AppString.films &&
              homeCubit.listFilms.isNotEmpty) {
            homeCubit.searchResultsCount = homeCubit.listFilms.length;
            return buildAnimatedList(
                context, homeCubit.listFilms, (film) => FilmCard(film: film));
          } else if (category == AppString.species &&
              homeCubit.listSpecies.isNotEmpty) {
            homeCubit.searchResultsCount = homeCubit.listSpecies.length;
            return buildAnimatedList(context, homeCubit.listSpecies,
                (species) => SpeciesCard(species: species));
          } else if (category == AppString.vehicles &&
              homeCubit.listVehicles.isNotEmpty) {
            homeCubit.searchResultsCount = homeCubit.listVehicles.length;
            return buildAnimatedList(context, homeCubit.listVehicles,
                (vehicle) => VehicleCard(vehicle: vehicle));
          } else if (category == AppString.starships &&
              homeCubit.listStarships.isNotEmpty) {
            homeCubit.searchResultsCount = homeCubit.listStarships.length;
            return buildAnimatedList(context, homeCubit.listStarships,
                (starship) => StarshipCard(starship: starship));
          } else if (state is GetPeopleErrorState ||
              state is GetPlanetsErrorState ||
              state is GetFilmsErrorState ||
              state is GetSpeciesErrorState ||
              state is GetVehiclesErrorState ||
              state is GetStarsShipsErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${AppString.failedFetchData}  $category'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: refreshData,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(AppString.noDataAvailable),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      refreshData();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

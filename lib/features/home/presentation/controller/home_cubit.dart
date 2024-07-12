import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_wars_app/core/utils/global.dart';
import 'package:star_wars_app/features/home/data/model/categories_model.dart';
import 'package:star_wars_app/features/home/data/model/favourite_model.dart';
import 'package:star_wars_app/features/home/data/model/film_model.dart';
import 'package:star_wars_app/features/home/data/model/people_model.dart';
import 'package:star_wars_app/features/home/data/model/planet_model.dart';
import 'package:star_wars_app/features/home/data/model/species_model.dart';
import 'package:star_wars_app/features/home/data/model/starship_model.dart';
import 'package:star_wars_app/features/home/data/model/vehicle_model.dart';
import 'package:star_wars_app/features/home/data/service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeInitState> {
  HomeCubit() : super(HomeInitState()) {
    _init();
  }

  static HomeCubit get(context) => BlocProvider.of(context);
  late SharedPreferences _preferences;
  final StartWarsService _startWarsService = StartWarsService();

  // Local storage keys
  static const String _categoriesKey = 'star_wars_categories';
  static const String _peopleKey = 'star_wars_people';
  static const String _planetsKey = 'star_wars_planets';
  static const String _filmsKey = 'star_wars_films';
  static const String _speciesKey = 'star_wars_species';
  static const String _starshipsKey = 'star_wars_starships';
  static const String _vehiclesKey = 'star_wars_vehicles';
  static const String _favoritesKey = 'favorites';

  // Categories model to hold all lists
  Categories categories = const Categories(
    people: '',
    planets: '',
    films: '',
    species: '',
    starships: '',
    vehicles: '', // Assuming vehicles are also fetched
  );

  // Initialize SharedPreferences instance and save empty lists
  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
    await _loadDataFromPreferences();
    refreshDataSearchResultsCount();
  }

  int currentTabIndex = 0;
  int currentNavIndex = 0;
  int searchResultsCount = 0;

  changeTabIndex(int index) {
    currentTabIndex = index;
    Global.txtSearchController.clear();
    restartAllLists();
    refreshDataSearchResultsCount();
    emit(ChangeTabIndexSuccessState());
  }

  changeNavIndex(int index) {
    currentNavIndex = index;
    if (currentNavIndex == 0) {
      currentTabIndex = 0;
      Global.txtSearchController.clear();
      restartAllLists();
      refreshDataSearchResultsCount();
    }
    emit(ChangeNavIndexSuccessState());
  }

  Future<void> loadDataFromServer() async {
    await getStarWarsCategories();
    await getStarWarsPeople();
    await getStarWarsPlanets();
    await getStarWarsFilms();
    await getStarWarsSpecies();
    await getStarWarsStarships();
    await getStarWarsVehicles();
  }

  // Load data from SharedPreferences
  Future<void> _loadDataFromPreferences() async {
    String? categoriesJson = _preferences.getString(_categoriesKey);
    if (categoriesJson != null) {
      categories = Categories.fromJson(jsonDecode(categoriesJson));
    }

    String? peopleJson = _preferences.getString(_peopleKey);
    if (peopleJson != null) {
      listStarWarsCharacter = List<StarWarsCharacter>.from(
          jsonDecode(peopleJson).map((x) => StarWarsCharacter.fromJson(x)));
      listStarWarsCharacterMaster = listStarWarsCharacter.toList();
    }

    String? planetsJson = _preferences.getString(_planetsKey);
    if (planetsJson != null) {
      listPlanets = List<Planet>.from(
          jsonDecode(planetsJson).map((x) => Planet.fromJson(x)));

      listPlanetsMaster = listPlanets.toList();
    }

    String? filmsJson = _preferences.getString(_filmsKey);
    if (filmsJson != null) {
      listFilms =
          List<Film>.from(jsonDecode(filmsJson).map((x) => Film.fromJson(x)));
      listFilmsMaster = listFilms.toList();
    }

    String? speciesJson = _preferences.getString(_speciesKey);
    if (speciesJson != null) {
      listSpecies = List<Species>.from(
          jsonDecode(speciesJson).map((x) => Species.fromJson(x)));
      listSpeciesMaster = listSpecies.toList();
    }

    String? starshipsJson = _preferences.getString(_starshipsKey);
    if (starshipsJson != null) {
      listStarships = List<Starship>.from(
          jsonDecode(starshipsJson).map((x) => Starship.fromJson(x)));
      listStarshipsMaster = listStarships.toList();
    }

    String? vehiclesJson = _preferences.getString(_vehiclesKey);
    if (vehiclesJson != null) {
      listVehicles = List<Vehicle>.from(
          jsonDecode(vehiclesJson).map((x) => Vehicle.fromJson(x)));
      listVehiclesMaster = listVehicles.toList();
    }

    _getFavorites();
  }

  // Save data to SharedPreferences
  Future<void> _saveDataToPreferences() async {
    await _preferences.setString(
        _categoriesKey, jsonEncode(categories.toJson()));
    await _preferences.setString(_peopleKey,
        jsonEncode(listStarWarsCharacter.map((e) => e.toJson()).toList()));
    await _preferences.setString(
        _planetsKey, jsonEncode(listPlanets.map((e) => e.toJson()).toList()));
    await _preferences.setString(
        _filmsKey, jsonEncode(listFilms.map((e) => e.toJson()).toList()));
    await _preferences.setString(
        _speciesKey, jsonEncode(listSpecies.map((e) => e.toJson()).toList()));
    await _preferences.setString(_starshipsKey,
        jsonEncode(listStarships.map((e) => e.toJson()).toList()));
    await _preferences.setString(
        _vehiclesKey, jsonEncode(listVehicles.map((e) => e.toJson()).toList()));
  }

  // Fetch Star Wars categories and update lists
  Future<void> getStarWarsCategories() async {
    emit(GetCategoriesLoadingState());
    try {
      Categories updatedCategories =
          await _startWarsService.getStarWarsRootWS();
      categories = updatedCategories;
      await _saveDataToPreferences();
      emit(GetCategoriesSuccessState());
    } catch (e) {
      emit(GetCategoriesErrorState());
    }
  }

  // Fetch individual categories and update lists
  List<StarWarsCharacter> listStarWarsCharacterMaster = [];
  List<StarWarsCharacter> listStarWarsCharacter = [];

  Future<void> getStarWarsPeople() async {
    emit(GetPeopleLoadingState());
    try {
      listStarWarsCharacterMaster =
          await _startWarsService.getStarWarsPeopleWS();
      listStarWarsCharacter = await _startWarsService.getStarWarsPeopleWS();
      refreshDataSearchResultsCount();

      await _saveDataToPreferences();

      emit(GetPeopleSuccessState());
    } catch (e) {
      emit(GetPeopleErrorState());
    }
  }

  List<Planet> listPlanetsMaster = [];
  List<Planet> listPlanets = [];

  Future<void> getStarWarsPlanets() async {
    emit(GetPlanetsLoadingState());
    try {
      listPlanetsMaster = await _startWarsService.getStartWarsPlanetsWS();
      listPlanets = await _startWarsService.getStartWarsPlanetsWS();
      refreshDataSearchResultsCount();
      await _saveDataToPreferences();
      emit(GetPlanetsSuccessState());
    } catch (e) {
      emit(GetPlanetsErrorState());
    }
  }

  List<Species> listSpeciesMaster = [];
  List<Species> listSpecies = [];

  Future<void> getStarWarsSpecies() async {
    emit(GetSpeciesLoadingState());
    try {
      listSpeciesMaster = await _startWarsService.getStarWarsSpecies();
      listSpecies = await _startWarsService.getStarWarsSpecies();
      refreshDataSearchResultsCount();
      await _saveDataToPreferences();
      emit(GetSpeciesSuccessState());
    } catch (e) {
      emit(GetSpeciesErrorState());
    }
  }

  List<Film> listFilmsMaster = [];
  List<Film> listFilms = [];

  Future<void> getStarWarsFilms() async {
    emit(GetFilmsLoadingState());
    try {
      listFilmsMaster = await _startWarsService.getStartWarsFilmsWS();
      listFilms = await _startWarsService.getStartWarsFilmsWS();
      refreshDataSearchResultsCount();
      await _saveDataToPreferences();
      emit(GetFilmsSuccessState());
    } catch (e) {
      emit(GetFilmsErrorState());
    }
  }

  List<Starship> listStarshipsMaster = [];
  List<Starship> listStarships = [];

  Future<void> getStarWarsStarships() async {
    emit(GetStarsShipsLoadingState());
    try {
      listStarshipsMaster = await _startWarsService.getStartWarsStarshipsWS();
      listStarships = await _startWarsService.getStartWarsStarshipsWS();
      refreshDataSearchResultsCount();
      await _saveDataToPreferences();
      emit(GetStarsShipsSuccessState());
    } catch (e) {
      emit(GetStarsShipsErrorState());
    }
  }

  List<Vehicle> listVehiclesMaster = [];
  List<Vehicle> listVehicles = [];

  Future<void> getStarWarsVehicles() async {
    emit(GetVehiclesLoadingState());
    try {
      listVehiclesMaster = await _startWarsService.getStarWarsVehicles();
      listVehicles = await _startWarsService.getStarWarsVehicles();
      refreshDataSearchResultsCount();
      await _saveDataToPreferences();
      emit(GetVehiclesSuccessState());
    } catch (e) {
      emit(GetVehiclesErrorState());
    }
  }

  // Methods to interact with shared preferences for favorites
  Future<void> saveFavorites({required List<Favourite> favorites}) async {
    List<Map<String, dynamic>> favJsonList =
        favorites.map((fav) => fav.toJson()).toList();
    await _preferences.setStringList(
        _favoritesKey, favJsonList.map((json) => jsonEncode(json)).toList());
    listFavoritesMaster = await _getFavorites();
    listFavorites = await _getFavorites();

    emit(SaveFavoritesSuccessState());
  }

  List<Favourite> listFavoritesMaster = [];
  List<Favourite> listFavorites = [];

  Future<List<Favourite>> _getFavorites() async {
    List<String>? favJsonStrings = _preferences.getStringList(_favoritesKey);
    if (favJsonStrings != null) {
      var listFav = favJsonStrings
          .map((jsonString) => Favourite.fromJson(jsonDecode(jsonString)))
          .toList();
      listFavoritesMaster = listFav;
      listFavorites = listFav;
      emit(GetFavoritesSuccessState());
      return listFav;
    } else {
      return [];
    }
  }

// Example methods for handling favorites
  Future<void> addToFavorites({required Favourite favourite}) async {
    List<Favourite> favorites = await _getFavorites();

    // Check if the favourite already exists in the list
    bool exists = favorites.any((fav) =>
        fav.sectionName == favourite.sectionName &&
        fav.itemId == favourite.itemId);

    if (exists) {
      // Remove the favourite if it already exists
      favorites.removeWhere((fav) =>
          fav.sectionName == favourite.sectionName &&
          fav.itemId == favourite.itemId);
    } else {
      // Add the favourite if it doesn't exist
      favorites.add(favourite);
    }

    await saveFavorites(favorites: favorites);
  }

  Future<void> removeFromFavorites({required Favourite favourite}) async {
    List<Favourite> favorites = await _getFavorites();
    favorites.removeWhere((fav) =>
        fav.sectionName == favourite.sectionName &&
        fav.itemId == favourite.itemId);
    await saveFavorites(favorites: favorites);
  }

  restartAllLists() {
    listStarWarsCharacter = listStarWarsCharacterMaster;
    listPlanets = listPlanetsMaster;
    listFilms = listFilmsMaster;
    listSpecies = listSpeciesMaster;
    listVehicles = listVehiclesMaster;
    listStarships = listStarshipsMaster;
    emit(RestartAllListsSuccessState());
  }

  Future<void> getSearchResults() async {
    String query = Global.txtSearchController.text.toLowerCase();

    if (query.isEmpty) {
      listStarWarsCharacter = listStarWarsCharacterMaster;
      listPlanets = listPlanetsMaster;
      listFilms = listFilmsMaster;
      listSpecies = listSpeciesMaster;
      listVehicles = listVehiclesMaster;
      listStarships = listStarshipsMaster;
    } else {
      switch (currentTabIndex) {
        case 0:
          listStarWarsCharacter = listStarWarsCharacterMaster
              .where((character) => character.searchableString.contains(query))
              .toList();

          break;
        case 1:
          listPlanets = listPlanetsMaster
              .where((planet) => planet.searchableString.contains(query))
              .toList();

          break;
        case 2:
          listFilms = listFilmsMaster
              .where((film) => film.searchableString.contains(query))
              .toList();

          break;
        case 3:
          listSpecies = listSpeciesMaster
              .where((species) => species.searchableString.contains(query))
              .toList();

          break;
        case 4:
          listVehicles = listVehiclesMaster
              .where((vehicle) => vehicle.searchableString.contains(query))
              .toList();

          break;
        case 5:
          listStarships = listStarshipsMaster
              .where((starship) => starship.searchableString.contains(query))
              .toList();
          break;
        default:
          break;
      }
    }

    refreshDataSearchResultsCount();
    emit(GetSearchResultsSuccessState());
  }

  refreshDataSearchResultsCount() {
    if (currentTabIndex == 0) {
      searchResultsCount = listStarWarsCharacter.length;
    } else if (currentTabIndex == 1) {
      searchResultsCount = listPlanets.length;
    } else if (currentTabIndex == 2) {
      searchResultsCount = listFilms.length;
    } else if (currentTabIndex == 3) {
      searchResultsCount = listSpecies.length;
    } else if (currentTabIndex == 4) {
      searchResultsCount = listVehicles.length;
    } else if (currentTabIndex == 5) {
      searchResultsCount = listStarships.length;
    }
    emit(RefreshDataSearchResultsCountSuccessState());
  }
}

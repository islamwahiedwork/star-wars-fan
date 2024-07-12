import 'package:dio/dio.dart';
import 'package:star_wars_app/core/network/dio_service.dart';
import 'package:star_wars_app/core/utils/app_constance.dart';
import 'package:star_wars_app/features/home/data/model/categories_model.dart';
import 'package:star_wars_app/features/home/data/model/film_model.dart';
import 'package:star_wars_app/features/home/data/model/people_model.dart';
import 'package:star_wars_app/features/home/data/model/planet_model.dart';
import 'package:star_wars_app/features/home/data/model/species_model.dart';
import 'package:star_wars_app/features/home/data/model/starship_model.dart';
import 'package:star_wars_app/features/home/data/model/vehicle_model.dart';

class StartWarsService {
  final DioService _dioService = DioService();

  Future<Categories> getStarWarsRootWS() async {
    print("getStarWarsRootWS");
    try {
      Response response =
          await _dioService.getRequest(path: "", queryParameters: {});
      print(response.data);
      if (response.statusCode == 200) {
        return Categories.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch Star Wars root data');
      }
    } catch (e) {
      throw Exception('Failed to fetch Star Wars root data: $e');
    }
  }

  Future<List<StarWarsCharacter>> getStarWarsPeopleWS() async {
    try {
      Response response = await _dioService
          .getRequest(path: AppConstance.people, queryParameters: {});
      if (response.statusCode == 200) {
        var data = response.data;
        var people = People.fromJson(data);
        return people.results;
      } else {
        throw Exception('Failed to fetch Star Wars people data');
      }
    } catch (e) {
      throw Exception('Failed to fetch Star Wars people data: $e');
    }
  }

  Future<List<Planet>> getStartWarsPlanetsWS() async {
    try {
      Response response = await _dioService
          .getRequest(path: AppConstance.planets, queryParameters: {});
      if (response.statusCode == 200) {
        var data = response.data;
        var results = data['results'] as List;
        return results
            .map((characterJson) => Planet.fromJson(characterJson))
            .toList();
      } else {
        throw Exception('Failed to fetch Star Wars planets data');
      }
    } catch (e) {
      throw Exception('Failed to fetch Star Wars planets data: $e');
    }
  }

  Future<List<Film>> getStartWarsFilmsWS() async {
    try {
      Response response = await _dioService
          .getRequest(path: AppConstance.films, queryParameters: {});
      if (response.statusCode == 200) {
        var data = response.data;
        var results = data['results'] as List;
        return results
            .map((characterJson) => Film.fromJson(characterJson))
            .toList();
      } else {
        throw Exception('Failed to fetch Star Wars film data');
      }
    } catch (e) {
      throw Exception('Failed to fetch Star Wars film data: $e');
    }
  }

  Future<List<Species>> getStarWarsSpecies() async {
    try {
      Response response = await _dioService
          .getRequest(path: AppConstance.species, queryParameters: {});

      if (response.statusCode == 200) {
        List<dynamic> speciesList = response.data['results'];
        List<Species> species =
            speciesList.map((json) => Species.fromJson(json)).toList();

        return species;
      } else {
        throw Exception('Failed to fetch Star Wars species data');
      }
    } catch (e) {
      throw Exception('Failed to fetch Star Wars species data: $e');
    }
  }

  Future<List<Vehicle>> getStarWarsVehicles() async {
    try {
      Response response = await _dioService
          .getRequest(path: AppConstance.vehicles, queryParameters: {});
      if (response.statusCode == 200) {
        List<dynamic> vehiclesList = response.data['results'];
        List<Vehicle> vehicles =
            vehiclesList.map((json) => Vehicle.fromJson(json)).toList();

        return vehicles;
      } else {
        throw Exception('Failed to fetch Star Wars vehicles data');
      }
    } catch (e) {
      throw Exception('Failed to fetch Star Wars vehicles data: $e');
    }
  }

  Future<List<Starship>> getStartWarsStarshipsWS() async {
    try {
      Response response = await _dioService
          .getRequest(path: AppConstance.starships, queryParameters: {});
      if (response.statusCode == 200) {
        var data = response.data;
        var results = data['results'] as List;
        return results
            .map((characterJson) => Starship.fromJson(characterJson))
            .toList();
      } else {
        throw Exception('Failed to fetch Star Wars starships data');
      }
    } catch (e) {
      throw Exception('Failed to fetch Star Wars starships data: $e');
    }
  }
}

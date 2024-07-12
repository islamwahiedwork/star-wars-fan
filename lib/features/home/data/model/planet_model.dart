import 'package:equatable/equatable.dart';

// Define the Planet class
class Planet extends Equatable {
  final String name;
  final String rotationPeriod;
  final String orbitalPeriod;
  final String diameter;
  final String climate;
  final String gravity;
  final String terrain;
  final String surfaceWater;
  final String population;
  final List<String> residents;
  final List<String> films;
  final String created;
  final String edited;
  final String url;

  const Planet({
    required this.name,
    required this.rotationPeriod,
    required this.orbitalPeriod,
    required this.diameter,
    required this.climate,
    required this.gravity,
    required this.terrain,
    required this.surfaceWater,
    required this.population,
    required this.residents,
    required this.films,
    required this.created,
    required this.edited,
    required this.url,
  });

  @override
  List<Object?> get props => [
    name,
    rotationPeriod,
    orbitalPeriod,
    diameter,
    climate,
    gravity,
    terrain,
    surfaceWater,
    population,
    residents,
    films,
    created,
    edited,
    url,
  ];

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      name: json['name'],
      rotationPeriod: json['rotation_period'],
      orbitalPeriod: json['orbital_period'],
      diameter: json['diameter'],
      climate: json['climate'],
      gravity: json['gravity'],
      terrain: json['terrain'],
      surfaceWater: json['surface_water'],
      population: json['population'],
      residents: List<String>.from(json['residents']),
      films: List<String>.from(json['films']),
      created: json['created'],
      edited: json['edited'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rotation_period': rotationPeriod,
      'orbital_period': orbitalPeriod,
      'diameter': diameter,
      'climate': climate,
      'gravity': gravity,
      'terrain': terrain,
      'surface_water': surfaceWater,
      'population': population,
      'residents': residents,
      'films': films,
      'created': created,
      'edited': edited,
      'url': url,
    };
  }

  String get searchableString => [
    name, rotationPeriod, orbitalPeriod, diameter, climate, gravity,
    terrain, surfaceWater, population, residents.join(' '),
    films.join(' '), created, edited, url
  ].join(' ').toLowerCase();
}

// Define the PaginatedPlanets class
class PaginatedPlanets extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  final List<Planet> results;

  const PaginatedPlanets({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  @override
  List<Object?> get props => [count, next, previous, results];

  factory PaginatedPlanets.fromJson(Map<String, dynamic> json) {
    return PaginatedPlanets(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List).map((i) => Planet.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((planet) => planet.toJson()).toList(),
    };
  }
}

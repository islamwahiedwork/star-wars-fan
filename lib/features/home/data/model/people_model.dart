import 'package:equatable/equatable.dart';

class People extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  final List<StarWarsCharacter> results;

  const People({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  @override
  List<Object?> get props => [count, next, previous, results];

  factory People.fromJson(Map<String, dynamic> json) {
    return People(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>?)
          ?.map((characterJson) => StarWarsCharacter.fromJson(characterJson))
          .toList() ?? [],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((x) => x.toJson()).toList(),
    };
  }


}




class StarWarsCharacter extends Equatable {
  final String name;
  final String height;
  final String mass;
  final String hairColor;
  final String skinColor;
  final String eyeColor;
  final String birthYear;
  final String gender;
  final String homeworld;
  final List<String> films;
  final List<String> species;
  final List<String> vehicles;
  final List<String> starships;
  final String created;
  final String edited;
  final String url;

  const StarWarsCharacter({
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.gender,
    required this.homeworld,
    required this.films,
    required this.species,
    required this.vehicles,
    required this.starships,
    required this.created,
    required this.edited,
    required this.url,
  });

  @override
  List<Object?> get props => [
    name, height, mass, hairColor, skinColor, eyeColor, birthYear,
    gender, homeworld, films, species, vehicles, starships,
    created, edited, url
  ];

  factory StarWarsCharacter.fromJson(Map<String, dynamic> json) {
    return StarWarsCharacter(
      name: json['name'] ?? '',
      height: json['height'] ?? '',
      mass: json['mass'] ?? '',
      hairColor: json['hair_color'] ?? '',
      skinColor: json['skin_color'] ?? '',
      eyeColor: json['eye_color'] ?? '',
      birthYear: json['birth_year'] ?? '',
      gender: json['gender'] ?? '',
      homeworld: json['homeworld'] ?? '',
      films: List<String>.from(json['films'] ?? []),
      species: List<String>.from(json['species'] ?? []),
      vehicles: List<String>.from(json['vehicles'] ?? []),
      starships: List<String>.from(json['starships'] ?? []),
      created: json['created'] ?? '',
      edited: json['edited'] ?? '',
      url: json['url'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'height': height,
      'mass': mass,
      'hair_color': hairColor,
      'skin_color': skinColor,
      'eye_color': eyeColor,
      'birth_year': birthYear,
      'gender': gender,
      'homeworld': homeworld,
      'films': films,
      'species': species,
      'vehicles': vehicles,
      'starships': starships,
      'created': created,
      'edited': edited,
      'url': url,
    };
  }
  String get searchableString {
    final List<String> nonNullValues = [
      name,
      height,
      mass,
      hairColor,
      skinColor,
      eyeColor,
      birthYear,
      gender,
      homeworld,
      ...films,
      ...species,
      ...vehicles,
      ...starships,
      created.toString(),
      edited.toString(),
      url,
    ].where((value) => value != '').map((value) => value.toString()).toList();

    return nonNullValues.join(' ').toLowerCase();
  }
}


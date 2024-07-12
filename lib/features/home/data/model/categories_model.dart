import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  final String people;
  final String planets;
  final String films;
  final String species;
  final String vehicles;
  final String starships;

  const Categories({
    required this.people,
    required this.planets,
    required this.films,
    required this.species,
    required this.vehicles,
    required this.starships,
  });

  @override
  List<Object?> get props => [people, planets, films, species, vehicles, starships];

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      people: json['people'],
      planets: json['planets'],
      films: json['films'],
      species: json['species'],
      vehicles: json['vehicles'],
      starships: json['starships'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'people': people,
      'planets': planets,
      'films': films,
      'species': species,
      'vehicles': vehicles,
      'starships': starships,
    };
  }
}

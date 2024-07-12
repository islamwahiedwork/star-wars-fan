import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Film extends Equatable {
  final String title;
  final int episodeId;
  final String openingCrawl;
  final String director;
  final String producer;
  final DateTime releaseDate;
  final List<String> characters;
  final List<String> planets;
  final List<String> starships;
  final List<String> vehicles;
  final List<String> species;

  const Film({
    required this.title,
    required this.episodeId,
    required this.openingCrawl,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.characters,
    required this.planets,
    required this.starships,
    required this.vehicles,
    required this.species,
  });

  @override
  List<Object?> get props => [
    title,
    episodeId,
    openingCrawl,
    director,
    producer,
    releaseDate,
    ...characters,
    ...planets,
    ...starships,
    ...vehicles,
    ...species,
  ];

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      title: json['title'],
      episodeId: json['episode_id'],
      openingCrawl: json['opening_crawl'],
      director: json['director'],
      producer: json['producer'],
      releaseDate: DateTime.parse(json['release_date']),
      characters: List<String>.from(json['characters']),
      planets: List<String>.from(json['planets']),
      starships: List<String>.from(json['starships']),
      vehicles: List<String>.from(json['vehicles']),
      species: List<String>.from(json['species']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'episode_id': episodeId,
      'opening_crawl': openingCrawl,
      'director': director,
      'producer': producer,
      'release_date': releaseDate.toIso8601String(),
      'characters': characters,
      'planets': planets,
      'starships': starships,
      'vehicles': vehicles,
      'species': species,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Film &&
              runtimeType == other.runtimeType &&
              title == other.title &&
              episodeId == other.episodeId &&
              openingCrawl == other.openingCrawl &&
              director == other.director &&
              producer == other.producer &&
              releaseDate == other.releaseDate &&
              listEquals(characters, other.characters) &&
              listEquals(planets, other.planets) &&
              listEquals(starships, other.starships) &&
              listEquals(vehicles, other.vehicles) &&
              listEquals(species, other.species);

  @override
  int get hashCode =>
      title.hashCode ^
      episodeId.hashCode ^
      openingCrawl.hashCode ^
      director.hashCode ^
      producer.hashCode ^
      releaseDate.hashCode ^
      characters.hashCode ^
      planets.hashCode ^
      starships.hashCode ^
      vehicles.hashCode ^
      species.hashCode;

  // Adding searchableString method
  String get searchableString => [
    title,
    episodeId.toString(),
    openingCrawl,
    director,
    producer,
    releaseDate.toIso8601String(),
    characters.join(' '),
    planets.join(' '),
    starships.join(' '),
    vehicles.join(' '),
    species.join(' ')
  ].join(' ').toLowerCase();
}

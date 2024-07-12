import 'package:equatable/equatable.dart';

class Starship extends Equatable {
  final String name;
  final String model;
  final String manufacturer;
  final String costInCredits;
  final String length;
  final String maxAtmospheringSpeed;
  final String crew;
  final String passengers;
  final String cargoCapacity;
  final String consumables;
  final String hyperdriveRating;
  final String MGLT;
  final String starshipClass;
  final List<String> pilotsUrls;
  final List<String> filmsUrls;
  final DateTime created;
  final DateTime edited;
  final String url;

  const Starship({
    required this.name,
    required this.model,
    required this.manufacturer,
    required this.costInCredits,
    required this.length,
    required this.maxAtmospheringSpeed,
    required this.crew,
    required this.passengers,
    required this.cargoCapacity,
    required this.consumables,
    required this.hyperdriveRating,
    required this.MGLT,
    required this.starshipClass,
    required this.pilotsUrls,
    required this.filmsUrls,
    required this.created,
    required this.edited,
    required this.url,
  });

  @override
  List<Object?> get props => [
    name,
    model,
    manufacturer,
    costInCredits,
    length,
    maxAtmospheringSpeed,
    crew,
    passengers,
    cargoCapacity,
    consumables,
    hyperdriveRating,
    MGLT,
    starshipClass,
    ...pilotsUrls,
    ...filmsUrls,
    created,
    edited,
    url,
  ];

  factory Starship.fromJson(Map<String, dynamic> json) {
    return Starship(
      name: json['name'],
      model: json['model'],
      manufacturer: json['manufacturer'],
      costInCredits: json['cost_in_credits'],
      length: json['length'],
      maxAtmospheringSpeed: json['max_atmosphering_speed'],
      crew: json['crew'],
      passengers: json['passengers'],
      cargoCapacity: json['cargo_capacity'],
      consumables: json['consumables'],
      hyperdriveRating: json['hyperdrive_rating'] ?? '',
      MGLT: json['MGLT'] ?? '',
      starshipClass: json['starship_class'] ?? '',
      pilotsUrls: List<String>.from(json['pilots'] ?? []),
      filmsUrls: List<String>.from(json['films'] ?? []),
      created: DateTime.parse(json['created']),
      edited: DateTime.parse(json['edited']),
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'model': model,
      'manufacturer': manufacturer,
      'cost_in_credits': costInCredits,
      'length': length,
      'max_atmosphering_speed': maxAtmospheringSpeed,
      'crew': crew,
      'passengers': passengers,
      'cargo_capacity': cargoCapacity,
      'consumables': consumables,
      'hyperdrive_rating': hyperdriveRating,
      'MGLT': MGLT,
      'starship_class': starshipClass,
      'pilots': pilotsUrls,
      'films': filmsUrls,
      'created': created.toIso8601String(),
      'edited': edited.toIso8601String(),
      'url': url,
    };
  }

  // Adding searchableString method
  String get searchableString => [
    name,
    model,
    manufacturer,
    costInCredits,
    length,
    maxAtmospheringSpeed,
    crew,
    passengers,
    cargoCapacity,
    consumables,
    hyperdriveRating,
    MGLT,
    starshipClass,
    pilotsUrls.join(' '),
    filmsUrls.join(' '),
    created.toIso8601String(),
    edited.toIso8601String(),
    url,
  ].join(' ').toLowerCase();
}

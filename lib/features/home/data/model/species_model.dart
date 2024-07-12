import 'package:equatable/equatable.dart';

class Species extends Equatable {
  final String name;
  final String classification;
  final String designation;
  final String averageHeight;
  final String skinColors;
  final String hairColors;
  final String eyeColors;
  final String averageLifespan;
  final String homeworld;
  final String language;
  final List<String> peopleUrls;
  final List<String> filmsUrls;
  final DateTime created;
  final DateTime edited;
  final String url;

  const Species({
    required this.name,
    required this.classification,
    required this.designation,
    required this.averageHeight,
    required this.skinColors,
    required this.hairColors,
    required this.eyeColors,
    required this.averageLifespan,
    required this.homeworld,
    required this.language,
    required this.peopleUrls,
    required this.filmsUrls,
    required this.created,
    required this.edited,
    required this.url,
  });

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      name: json['name'] ?? '',
      classification: json['classification'] ?? '',
      designation: json['designation'] ?? '',
      averageHeight: json['average_height'] ?? '',
      skinColors: json['skin_colors'] ?? '',
      hairColors: json['hair_colors'] ?? '',
      eyeColors: json['eye_colors'] ?? '',
      averageLifespan: json['average_lifespan'] ?? '',
      homeworld: json['homeworld'] ?? '',
      language: json['language'] ?? '',
      peopleUrls: (json['people'] as List<dynamic>?)?.map((url) => url.toString()).toList() ?? [],
      filmsUrls: (json['films'] as List<dynamic>?)?.map((url) => url.toString()).toList() ?? [],
      created: DateTime.tryParse(json['created'] ?? '') ?? DateTime.now(),
      edited: DateTime.tryParse(json['edited'] ?? '') ?? DateTime.now(),
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'classification': classification,
      'designation': designation,
      'average_height': averageHeight,
      'skin_colors': skinColors,
      'hair_colors': hairColors,
      'eye_colors': eyeColors,
      'average_lifespan': averageLifespan,
      'homeworld': homeworld,
      'language': language,
      'people': peopleUrls,
      'films': filmsUrls,
      'created': created.toIso8601String(),
      'edited': edited.toIso8601String(),
      'url': url,
    };
  }

  @override
  List<Object?> get props => [
    name,
    classification,
    designation,
    averageHeight,
    skinColors,
    hairColors,
    eyeColors,
    averageLifespan,
    homeworld,
    language,
    ...peopleUrls,
    ...filmsUrls,
    created,
    edited,
    url,
  ];

  // Adding searchableString method
  String get searchableString => [
    name,
    classification,
    designation,
    averageHeight,
    skinColors,
    hairColors,
    eyeColors,
    averageLifespan,
    homeworld,
    language,
    peopleUrls.join(' '),
    filmsUrls.join(' '),
    created.toIso8601String(),
    edited.toIso8601String(),
    url
  ].join(' ').toLowerCase();
}

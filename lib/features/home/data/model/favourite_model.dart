import 'package:equatable/equatable.dart';

class Favourite extends Equatable {
  final String sectionName;
  final String itemId;



  const Favourite({
    required this.sectionName,
    required this.itemId,

  });

  @override
  List<Object?> get props => [sectionName, itemId];

  factory Favourite.fromJson(Map<String, dynamic> json) {
    return Favourite(
      sectionName: json['sectionName'],
      itemId: json['itemId'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sectionName': sectionName,
      'itemId': itemId,

    };
  }
}

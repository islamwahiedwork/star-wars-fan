import 'package:flutter/material.dart';
import 'package:star_wars_app/core/utils/app_string.dart';
import 'package:star_wars_app/features/home/data/model/favourite_model.dart';
import 'package:star_wars_app/features/home/data/model/vehicle_model.dart';
import 'package:star_wars_app/features/home/presentation/controller/home_cubit.dart';
import 'high_light_text/high_light_text.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    bool isFavorite = HomeCubit.get(context).listFavorites.any((element) =>
        element.itemId == vehicle.name &&
        element.sectionName == AppString.vehicles);
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HighlightedTextWidgetForHeader(
                  text: vehicle.name,
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    HomeCubit.get(context).addToFavorites(
                        favourite: Favourite(
                            sectionName: AppString.vehicles,
                            itemId: vehicle.name));
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            HighlightedTextWidget(titleText: 'Model: ', text: vehicle.model),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Manufacturer: ', text: vehicle.manufacturer),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Cost in credits: ', text: vehicle.costInCredits),
            const SizedBox(height: 4),
            HighlightedTextWidget(titleText: 'Length: ', text: vehicle.length),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Max atmospheric speed: ',
                text: vehicle.maxAtmospheringSpeed),
            const SizedBox(height: 4),
            HighlightedTextWidget(titleText: 'Crew: ', text: vehicle.crew),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Passengers: ', text: vehicle.passengers),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Cargo capacity: ', text: vehicle.cargoCapacity),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Consumables: ', text: vehicle.consumables),
            const SizedBox(height: 4),
            HighlightedTextWidget(
                titleText: 'Vehicle class: ', text: vehicle.vehicleClass),
          ],
        ),
      ),
    );
  }
}

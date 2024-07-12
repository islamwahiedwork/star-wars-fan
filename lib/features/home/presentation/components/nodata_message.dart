import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  final String message;
  final IconData? icon;

  const CenteredMessage({
    Key? key,
    required this.message,
    this.icon, // Optional icon parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData defaultIcon =
        Icons.favorite_border; // Default icon when no specific icon is provided
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon ?? defaultIcon, // Use provided icon or default icon
            size: 40,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

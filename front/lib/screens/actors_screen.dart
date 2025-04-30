import 'package:flutter/material.dart';
import 'package:flutter_application_base/screens/actors_list.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ActorsScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;

  const ActorsScreen({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    final String apiUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000/api/v1';

    return ActorsListScreen(
      apiUrl: '$apiUrl/actors',
      screenTitle: 'Actores',
      onThemeChanged: onThemeChanged,
    );
  }
}

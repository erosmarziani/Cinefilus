import 'package:flutter/material.dart';
import 'package:flutter_application_base/screens/movie_list_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PopularScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;

  const PopularScreen({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    final String apiUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000/api/v1';

    return MovieListScreen(
      apiUrl: '$apiUrl/popular?lang=es-ES',
      screenTitle: 'Peliculas Populares',
      onThemeChanged: onThemeChanged,
    );
  }
}


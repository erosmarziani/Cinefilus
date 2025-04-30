import 'package:flutter/material.dart';
import 'package:flutter_application_base/screens/tvseries_list_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TvShowsScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;

  const TvShowsScreen({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    final String apiUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000/api/v1';

    return SeriesListScreen(
      apiUrl: '$apiUrl/tv?lang=es-ES',
      screenTitle: 'Series',
      onThemeChanged: onThemeChanged,
    );
  }
}
  
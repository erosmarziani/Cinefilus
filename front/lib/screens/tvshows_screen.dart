import 'package:flutter/material.dart';
import 'package:flutter_application_base/widgets/movie_list_screen.dart';

class TvShowsScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;

  const TvShowsScreen({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return MovieListScreen(
      apiUrl: 'http://localhost:3000/api/v1/tv',
      screenTitle: 'Series',
      onThemeChanged: onThemeChanged,
    );
  }
}
  
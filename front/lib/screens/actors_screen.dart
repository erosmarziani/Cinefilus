import 'package:flutter/material.dart';
import 'package:flutter_application_base/widgets/actors_screen.dart';

class ActorsScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;

  const ActorsScreen({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return ActorsListScreen(
      apiUrl: 'http://localhost:3000/api/v1/actors',
      screenTitle: 'Actores',
      onThemeChanged: onThemeChanged,
    );
  }
}


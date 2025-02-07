import 'package:flutter/material.dart';
import '../widgets/populares_detail.dart';
import '../mocks/puntuados_mocks.dart';
import 'package:flutter_application_base/screens/movie_rating_screen.dart';


class PopularMoviesScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;

  const PopularMoviesScreen({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textColor = brightness == Brightness.dark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas Populares'),
        backgroundColor: brightness == Brightness.dark ? Colors.black : Colors.cyan,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add-movie');
            },
            tooltip: 'Agregar Película',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockData.length,
        itemBuilder: (context, index) {
          final movie = mockData[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  movie['image_url'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                movie['title'],
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Puntuación: ${movie['vote_average']} | Votos: ${movie['vote_count']}',
                style: TextStyle(color: textColor),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieRatingScreen(movie: movie),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          Navigator.pushNamed(context, '/add-movie');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
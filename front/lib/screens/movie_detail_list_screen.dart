import 'package:flutter/material.dart';
import '../mocks/mock_movies.dart'; 
import 'movie_detail_screen.dart'; 

class MovieDetailListScreen extends StatelessWidget {
  final Function(bool) onThemeChanged; 

  const MovieDetailListScreen(
      {super.key,
      required this.onThemeChanged}); 

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textColor =
        brightness == Brightness.dark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Películas"),
        backgroundColor:
            brightness == Brightness.dark ? Colors.black : Colors.cyan,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockData.length,
        itemBuilder: (context, index) {
          final movie = mockData[index]; 

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(movie[
                    'imageUrl']), 
              ),
              title: Text(
                movie['title'], 
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(
                        movie:
                            movie),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

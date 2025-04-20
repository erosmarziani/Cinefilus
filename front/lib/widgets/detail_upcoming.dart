/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_base/screens/movie_rating_screen.dart';

class PopularMoviesScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;

  const PopularMoviesScreen({super.key, required this.onThemeChanged});

  @override
  _PopularMoviesScreenState createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  List<dynamic> movies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final url = Uri.parse("http://127.0.0.1:3000/movies/upcoming"); // Cambia la URL según tu API
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          movies = responseData["data"]; // Extraer solo las películas
          isLoading = false;
        });
      } else {
        throw Exception("Error en la solicitud: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textColor = brightness == Brightness.dark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas Próximas a Estrenar'),
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Indicador de carga
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: movie['poster_path'] != null
                          ? Image.network(
                              "https://image.tmdb.org/t/p/w200${movie['poster_path']}", // API de imágenes de TMDB
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported),
                            )
                          : const Icon(Icons.image_not_supported),
                    ),
                    title: Text(
                      movie['title'] ?? "Título no disponible",
                      style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Estreno: ${movie['release_date'] ?? "No disponible"}\n'
                      'Puntuación: ${movie['vote_average'] ?? 0.0} | Votos: ${movie['vote_count'] ?? 0}',
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
*/
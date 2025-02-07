import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_base/widgets/detail_classic.dart';
import 'package:http/http.dart' as http;

/// Función para extraer el año del campo 'release_date'
String getYear(String releaseDate) {
  if (releaseDate != null && releaseDate.length >= 4) {
    return releaseDate.substring(0, 4);
  }
  return 'N/D';
}

/// Función para mapear la lista de genre_ids a nombres legibles
String getGenres(List<dynamic> genreIds) {
  final Map<int, String> genreMapping = {
    28: 'Acción',
    12: 'Aventura',
    16: 'Animación',
    35: 'Comedia',
    80: 'Crimen',
    99: 'Documental',
    18: 'Drama',
    10751: 'Familia',
    14: 'Fantasía',
    36: 'Historia',
    27: 'Terror',
    10402: 'Música',
    9648: 'Misterio',
    10749: 'Romance',
    878: 'Ciencia Ficción',
    10770: 'TV',
    53: 'Thriller',
    10752: 'Guerra',
    37: 'Oeste',
  };

  if (genreIds == null || genreIds.isEmpty) return 'Desconocido';

  List<String> genres = [];
  for (var id in genreIds) {
    genres.add(genreMapping[id] ?? 'Desconocido');
  }
  return genres.join(', ');
}

class ClassicMoviesScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;

  const ClassicMoviesScreen({super.key, required this.onThemeChanged});

  @override
  _ClassicMoviesScreenState createState() => _ClassicMoviesScreenState();
}

class _ClassicMoviesScreenState extends State<ClassicMoviesScreen> {
  bool isLoading = true;
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final url = Uri.parse("http://localhost:3001/upcoming"); // Ajusta la URL según tu API
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          movies = responseData['data']; // Se asume que 'data' contiene la lista de películas
          isLoading = false;
        });
      } else {
        throw Exception('Error al obtener las películas');
      }
    } catch (e) {
      print('Error: $e');
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
        title: const Text('Clásicos del Cine'),
        backgroundColor: brightness == Brightness.dark ? Colors.black : Colors.cyan,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                // Extraemos el año y los géneros utilizando nuestras funciones helper.
                final String year = movie['release_date'] != null
                    ? getYear(movie['release_date'])
                    : 'No disponible';
                final String genres = movie['genre_ids'] != null
                    ? getGenres(movie['genre_ids'])
                    : 'Desconocido';

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    // Si la película tiene 'poster_path', se muestra la imagen; de lo contrario, se muestra un ícono.
                    leading: movie['poster_path'] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w200${movie['poster_path']}",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported),
                            ),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.cyan,
                            child: Icon(Icons.movie, color: Colors.white),
                          ),
                    title: Text(
                      movie['title'] ?? "Título no disponible",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Puntuación: ${movie['vote_average']} | Votos: ${movie['vote_count']}',
                          style: TextStyle(color: textColor, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Año: $year | Género: $genres',
                          style: TextStyle(color: textColor, fontSize: 14),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Al tocar un ítem, se navega a la pantalla de detalle pasando el objeto 'movie'.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClassicScreen(movie: movie),
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

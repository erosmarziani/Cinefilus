import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_base/models/movies.dart';
import 'package:flutter_application_base/screens/movie_detail_screen.dart';
import 'package:flutter_application_base/helpers/helpers.dart';
import 'package:http/http.dart' as http;

class MovieListScreen extends StatefulWidget {
  final String apiUrl;
  final String screenTitle;
  final Function(bool) onThemeChanged;

  const MovieListScreen({
    super.key,
    required this.apiUrl,
    required this.screenTitle,
    required this.onThemeChanged,
  });

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  bool isLoading = true;
  List<Movie> movies = [];
  List<Movie> filteredMovies = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final url = Uri.parse(widget.apiUrl);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final movieResponse = movieFromJson(response.body);
        setState(() {
          movies = movieResponse.data;
          filteredMovies = movieResponse.data;
          isLoading = false;
        });
      } else {
        throw Exception('Error al obtener las películas');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar las películas: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void filterMovies(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredMovies = movies.where((movie) {
        final title = movie.title.toLowerCase();
        final genres = getGenres(movie.genreIds).toLowerCase();
        return title.contains(searchQuery) || genres.contains(searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
   final brightness = Theme.of(context).brightness;
  final isDark = brightness == Brightness.dark;

  // Definir los colores para tema claro y oscuro
  final textColor = isDark ? Colors.white : Color(0xFF333333); // Gris oscuro en claro
  final backgroundColor = isDark ? Color(0xFF121212) : Color(0xFFF7F7F7); // Gris oscuro en modo oscuro y gris muy suave en claro
  final cardColor = isDark ? Color(0xFF1C1C1C) : Color(0xFFF3F3F3); // Gris oscuro para el modo oscuro y gris muy claro para el claro
  final accentColor = isDark ? Color(0xFF4CAF50) : Color(0xFF00897B); // Verde vibrante para el oscuro y verde suave para el claro

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Color(0xFF00ACC1),
        title: Text(
          widget.screenTitle,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    onChanged: filterMovies,
                    decoration: InputDecoration(
                      labelText: 'Buscar por título o género',
                      prefixIcon: Icon(Icons.search, color: textColor),
                      labelStyle: TextStyle(color: textColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: textColor.withOpacity(0.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: textColor),
                      ),
                    ),
                    style: TextStyle(color: textColor),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredMovies.length,
                    itemBuilder: (context, index) {
                      final movie = filteredMovies[index];
                      final year = movie.releaseDate.year.toString();
                      final genres = getGenres(movie.genreIds);

                      return Card(
                        color: cardColor,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 3,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: movie.posterPath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.image_not_supported),
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.cyan,
                                  child: Icon(Icons.movie, color: Colors.white),
                                ),
                          title: Text(
                            movie.title,
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
                                'Puntuación: ${movie.voteAverage} | Votos: ${movie.voteCount}',
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MovieDetailScreen(movie: movie),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

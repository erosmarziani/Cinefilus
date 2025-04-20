import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_base/widgets/movie_detail_screen.dart';
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
  List<dynamic> movies = [];
  List<dynamic> filteredMovies = [];
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
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          movies = responseData['data'];
          filteredMovies = movies;
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
        final title = (movie['title'] ?? '').toLowerCase();
        final genres = getGenres(movie['genre_ids']).toLowerCase();
        return title.contains(searchQuery) || genres.contains(searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textColor =
        brightness == Brightness.dark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.screenTitle),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    onChanged: (value) {
                      filterMovies(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Buscar por título o género',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredMovies.length,
                    itemBuilder: (context, index) {
                      final movie = filteredMovies[index];
                      final year = getYear(movie['release_date'] ?? '');
                      final genres = getGenres(movie['genre_ids']);

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: movie['poster_path'] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w200${movie['poster_path']}",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.image_not_supported),
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.cyan,
                                  child: Icon(Icons.movie, color: Colors.white),
                                ),
                          title: Text(
                            movie['title'] ??
                                movie['name'] ??
                                "Título no disponible",
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
                                style: TextStyle(
                                    color: textColor, fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Año: $year | Género: $genres',
                                style: TextStyle(
                                    color: textColor, fontSize: 14),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailScreen(movie: movie),
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

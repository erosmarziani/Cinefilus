import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier {
  List<dynamic> _movies = [];
  List<dynamic> _filteredMovies = [];
  bool isLoading = true;
  String _searchQuery = '';

  List<dynamic> get filteredMovies => _filteredMovies;

  void loadMovies(List<dynamic> movies) {
    _movies = movies;
    _filteredMovies = movies; // Inicialmente mostrar todas las películas
    notifyListeners();
  }

  void filterMovies(String query) {
    _searchQuery = query.toLowerCase();
    _filteredMovies = _movies.where((movie) {
      final title = (movie['title'] ?? '').toLowerCase();
      final genres = getGenres(movie['genre_ids']).toLowerCase();
      return title.contains(_searchQuery) || genres.contains(_searchQuery);
    }).toList();
    notifyListeners();
  }

  String getYear(String releaseDate) {
    if (releaseDate.isNotEmpty && releaseDate.length >= 4) {
      return releaseDate.substring(0, 4);
    }
    return 'N/D';
  }

  getGenres(List<dynamic> genreIds) {
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
    if (genreIds.isEmpty) return 'Desconocido';

    return genreIds.map((genreId) => genreMapping[genreId]).join(', ');

  }
}

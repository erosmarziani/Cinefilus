import 'package:flutter_application_base/constants/genre_constants.dart';

/// Función para extraer el año del campo 'release_date'
String getYear(String releaseDate) {
  if (releaseDate != null && releaseDate.length >= 4) {
    return releaseDate.substring(0, 4);
  }
  return 'N/D';
}

/// Mapea una lista de IDs de género a su representación en texto
String getGenres(List<dynamic> genreIds) {
  if (genreIds == null || genreIds.isEmpty) return 'Desconocido';

  List<String> genres = [];
  for (var id in genreIds) {
    genres.add(genreMapping[id] ?? 'Desconocido');
  }
  return genres.join(', ');
}
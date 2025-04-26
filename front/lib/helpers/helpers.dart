import 'package:flutter_application_base/constants/genre_constants.dart';


/// Mapea una lista de IDs de género a su representación en texto
String getGenres(List<dynamic> genreIds) {
  if (genreIds.isEmpty || genreIds.isEmpty) return 'Desconocido';

  List<String> genres = [];
  for (var id in genreIds) {
    genres.add(genreMapping[id] ?? 'Desconocido');
  }
  return genres.join(', ');
}
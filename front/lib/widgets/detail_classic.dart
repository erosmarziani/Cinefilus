import 'package:flutter/material.dart';

/// Función para extraer el año de "release_date" (formato "YYYY-MM-DD")
String getYear(String releaseDate) {
  if (releaseDate != null && releaseDate.length >= 4) {
    return releaseDate.substring(0, 4);
  }
  return 'N/D';
}

/// Función para mapear genre_ids a nombres de géneros
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

  List<String> genres = [];
  if (genreIds != null) {
    for (var id in genreIds) {
      genres.add(genreMapping[id] ?? 'Desconocido');
    }
  }
  return genres.join(', ');
}

class ClassicScreen extends StatefulWidget {
  final Map<String, dynamic> movie;

  const ClassicScreen({super.key, required this.movie});

  @override
  _ClassicScreenState createState() => _ClassicScreenState();
}

class _ClassicScreenState extends State<ClassicScreen> {
  bool isFavorite = false;
  String personalNote = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = personalNote;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    final brightness = Theme.of(context).brightness;
    final textColor = Colors.white;

    // Construir la URL de la imagen (poster)
    final posterPath = movie['poster_path'];
    final imageUrl = posterPath != null
        ? "https://image.tmdb.org/t/p/w500$posterPath"
        : null;

    // Extraer el año desde "release_date"
    final releaseDate = movie['release_date'] ?? '';
    final year = getYear(releaseDate);

    // Convertir genre_ids a nombres de géneros
    final genres = movie['genre_ids'] != null ? getGenres(movie['genre_ids']) : 'Desconocido';

    // Usar "overview" como descripción, ya que es lo que devuelve la API
    final description = movie['overview'] ?? 'No hay descripción disponible.';

    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title'] ?? "Sin título"),
        backgroundColor: brightness == Brightness.dark ? Colors.black : Colors.cyan,
      ),
      body: Stack(
        children: [
          // Imagen de fondo (poster)
          if (imageUrl != null)
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Colors.black),
              ),
            ),
          // Capa semitransparente para mejor legibilidad
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          // Contenido de la pantalla
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const SizedBox(height: 16),
                // Título de la película
                Text(
                  movie['title'] ?? "Sin título",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
                // Puntuación y votos
                Text(
                  'Puntuación: ${movie['vote_average']} | Votos: ${movie['vote_count']}',
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
                const SizedBox(height: 8),
                // Año y Género
                Text(
                  'Año: $year | Género: $genres',
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
                const SizedBox(height: 16),
                // Descripción de la película
                Text(
                  'Descripción:',
                  style: TextStyle(fontSize: 18, color: textColor),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
                const SizedBox(height: 16),
                // Switch para marcar como favorita
                Row(
                  children: [
                    Text(
                      '¿Es tu favorita?',
                      style: TextStyle(fontSize: 18, color: textColor),
                    ),
                    Switch(
                      value: isFavorite,
                      onChanged: (bool value) {
                        setState(() {
                          isFavorite = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Campo de texto para nota personal
                Text(
                  'Nota personal sobre la película:',
                  style: TextStyle(fontSize: 18, color: textColor),
                ),
                TextFormField(
                  controller: _controller,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Escribe tu comentario...',
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  onChanged: (value) {
                    setState(() {
                      personalNote = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Botón para guardar cambios
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cambios guardados!')),
                    );
                  },
                  child: const Text('Guardar Cambios'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

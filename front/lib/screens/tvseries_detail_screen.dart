import 'package:flutter/material.dart';
import 'package:flutter_application_base/helpers/helpers.dart';
import 'package:flutter_application_base/models/tvshows.dart';

class SeriesDetailScreen extends StatefulWidget {
  final Series series;

  const SeriesDetailScreen({super.key, required this.series});

  @override
  _SeriesDetailScreen createState() => _SeriesDetailScreen();
}

class _SeriesDetailScreen extends State<SeriesDetailScreen> {
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
    final series = widget.series;
    final brightness = Theme.of(context).brightness;
    final textColor = Colors.white;

    // Construir la URL de la imagen (poster)
    final posterPath = series.posterPath;
    final imageUrl = posterPath != null
        ? "https://image.tmdb.org/t/p/w500$posterPath"
        : null;

    // Extraer el año desde "release_date"
    final year = series.firstAirDate.year.toString();
    ;

    // Convertir genre_ids a nombres de géneros
    final genres = getGenres(series.genreIds);

    // Usar "overview" como descripción, ya que es lo que devuelve la API
    final description = series.overview;

    return Scaffold(
      appBar: AppBar(
        title: Text(series.name),
        backgroundColor:
            brightness == Brightness.dark ? Colors.black : Colors.cyan,
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
                  series.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
                // Puntuación y votos
                Text(
                  'Puntuación: ${series.voteAverage} | Votos: ${series.voteCount}',
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

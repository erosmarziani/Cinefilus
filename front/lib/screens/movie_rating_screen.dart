import 'package:flutter/material.dart';

class MovieRatingScreen extends StatefulWidget {
  final Map<String, dynamic> movie;

  const MovieRatingScreen({super.key, required this.movie});

  @override
  State<MovieRatingScreen> createState() => _MovieRatingScreenState();
}

class _MovieRatingScreenState extends State<MovieRatingScreen> {
  double _userRating = 0;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie['title']),
        backgroundColor: brightness == Brightness.dark ? Colors.black : Colors.cyan,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.movie['image_url']),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Puntuación: ${widget.movie['vote_average']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Votos: ${widget.movie['vote_count']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Descripción:',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.movie['description'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    '¿Cuánto te gustó esta película?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Slider(
                    value: _userRating,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: _userRating.toString(),
                    activeColor: Colors.amber,
                    inactiveColor: Colors.white70,
                    onChanged: (value) {
                      setState(() {
                        _userRating = value;
                      });
                    },
                  ),
                  Center(
                    child: Text(
                      'Tu puntuación: ${_userRating.toStringAsFixed(1)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MovieDetailScreen extends StatefulWidget {
  final Map<String, dynamic> movie; 

  const MovieDetailScreen({super.key, required this.movie});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  double _rating = 0; 
  final TextEditingController _commentController =
      TextEditingController(); 

  void _sendComment() {
    if (_commentController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comentario enviado')),
      );

      _commentController.clear();

      setState(() {
        _rating = 0;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, escribe un comentario')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textColor = brightness == Brightness.dark
        ? const Color.fromARGB(255, 0, 0, 0)
        : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie['title'],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor:
            brightness == Brightness.dark ? Colors.black : Colors.cyan,
      ),
      body: Stack(
        children: [
          // Fondo de la película
          Positioned.fill(
            child: Image.asset(
              widget.movie['imageUrl'],
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.9),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sinopsis: ${widget.movie['synopsis']}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Año: ${widget.movie['year']}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Género: ${widget.movie['genre']}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Escribe un comentario:',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller:
                                _commentController, 
                            maxLines: 1,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "Escribe tu comentario",
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Botón para enviar comentario
                        ElevatedButton(
                          onPressed:
                              _sendComment, 
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.cyan),
                          ),
                          child: const Text("Enviar"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Calificación:',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _rating =
                                  index + 1.0;
                            });
                          },
                          child: Icon(
                            index < _rating ? Icons.star : Icons.star_border,
                            color: Colors.yellow,
                            size: 40,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

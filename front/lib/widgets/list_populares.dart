import 'package:flutter/material.dart';
import '../mocks/classic_mocks.dart';  // Asegúrate de tener los datos de películas

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textColor = brightness == Brightness.dark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Películas'),
        backgroundColor: brightness == Brightness.dark ? Colors.black : Colors.cyan,
      ),
      body: ListView.builder(
        itemCount: mockData.length,
        itemBuilder: (context, index) {
          final movie = mockData[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(movie['vote_average'].toString()),
              ),
              title: Text(movie['title']),
              subtitle: Text(
                'Votos: ${movie['vote_count']}',
                style: TextStyle(color: textColor),
              ),
              onTap: () {
                // Navega a la pantalla de detalles con los datos de la película
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: movie,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

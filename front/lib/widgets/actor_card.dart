import 'package:flutter/material.dart';

class ActorCard extends StatelessWidget {
  final Map<String, dynamic> actor;
  final Color textColor;
  final VoidCallback onTap; // Función que se llama cuando se hace tap en la tarjeta

  const ActorCard({
    super.key,
    required this.actor,
    required this.textColor,
    required this.onTap, // Se pasa la función como parámetro
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap, // Llamar a la función onTap cuando se hace tap en la tarjeta
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del actor (si hay)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  actor['image'] ?? 'https://via.placeholder.com/150',
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),
              // Nombre del actor
              Text(
                actor['name'],
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Descripción corta
              Text(
                actor['description'],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


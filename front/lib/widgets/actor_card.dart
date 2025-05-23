import 'package:flutter/material.dart';
import 'package:flutter_application_base/models/actor.dart';

class ActorCard extends StatelessWidget {
  final Actor actor;
  final Color textColor;
  final VoidCallback onTap;

  const ActorCard({
    super.key,
    required this.actor,
    required this.textColor,
    required this.onTap,
  });

  String getPopularityLabel(double popularity) {
    if (popularity > 7) {
      return '🌟 Superestrella';
    } else if (popularity > 6) {
      return '🔥 Muy Popular';
    } else if (popularity > 4) {
      return '🌱 Emergente';
    } else {
      return '🔍 Poco Conocido';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String popularityText = getPopularityLabel(actor.popularity ?? 0.0);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://image.tmdb.org/t/p/w200${actor.profilePath}",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                actor.name ?? 'Nombre no disponible',
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                popularityText,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                actor.name ?? 'Descripción no disponible',
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

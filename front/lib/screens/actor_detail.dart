import 'package:flutter/material.dart';
import 'package:flutter_application_base/models/actor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActorDetailScreen extends StatefulWidget {
  final Actor actor;

  const ActorDetailScreen({super.key, required this.actor});

  @override
  _ActorDetailScreenState createState() => _ActorDetailScreenState();
}

class _ActorDetailScreenState extends State<ActorDetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus(); // Cargar el estado guardado al iniciar
  }

  // Función para cargar el estado de favorito
  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool(widget.actor.name) ?? false;
    });
  }

  // Función para guardar el estado de favorito y que persista
  Future<void> _saveFavoriteStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.actor.name, value);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textColor =
        brightness == Brightness.dark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.actor.name),
        backgroundColor:
            brightness == Brightness.dark ? Colors.black : Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: ClipOval(
                  child: Container(
                    width: 160, // Aumenta el tamaño de la imagen
                    height: 160, // Aumenta el tamaño de la imagen
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: widget.actor.profilePath != null
                            ? NetworkImage(
                                "https://image.tmdb.org/t/p/w200${widget.actor.profilePath}")
                            : AssetImage('assets/images/default_avatar.png')
                                as ImageProvider,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.actor.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.actor.originalName ?? "Nombre original no disponible",
                style: TextStyle(fontSize: 16, color: textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿Es tu actor favorito?',
                    style: TextStyle(fontSize: 18, color: textColor),
                  ),
                  Switch(
                    value: isFavorite,
                    onChanged: (bool value) {
                      setState(() {
                        isFavorite = value;
                      });
                      _saveFavoriteStatus(value);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'animated_card.dart';

class ActorDetailScreen extends StatefulWidget {
  final Map<String, dynamic> actor;

  const ActorDetailScreen({super.key, required this.actor});

  //state como en react.
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
      isFavorite = prefs.getBool(widget.actor['name']) ?? false;
    });
  }

  // Función para guardar el estado de favorito y q persista
  Future<void> _saveFavoriteStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.actor['name'], value);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textColor = brightness == Brightness.dark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.actor['name']),
        backgroundColor: brightness == Brightness.dark ? Colors.black : Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(widget.actor['image']),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.actor['name'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.actor['description'],
                style: TextStyle(fontSize: 16, color: textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Películas:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2,
                ),
                itemCount: widget.actor['movies'].length,
                itemBuilder: (context, index) {
                  return AnimatedCard(
                    movieTitle: widget.actor['movies'][index],
                    textColor: textColor,
                  );
                },
              ),
              const SizedBox(height: 16),
              // Switch para marcar como favorito
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

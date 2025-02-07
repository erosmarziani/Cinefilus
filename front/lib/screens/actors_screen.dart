import 'package:flutter/material.dart';
import 'package:flutter_application_base/screens/home_screen.dart';
import '../mocks/actores.dart'; // Archivo donde están los datos mock
import '../widgets/actor_card.dart'; // Widget reutilizable para cada actor
import '../widgets/actor_detail.dart'; // Pantalla de detalles del actor

class ActorsScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;

  const ActorsScreen({super.key, required this.onThemeChanged});

  @override
  _ActorsScreenState createState() => _ActorsScreenState();
}

class _ActorsScreenState extends State<ActorsScreen> {
  final _formKey = GlobalKey<FormState>(); // Clave para manejar el formulario
  String searchQuery = '';
  List<Map<String, dynamic>> filteredActors = [];

  @override
  void initState() {
    super.initState();

    filteredActors = actors;
  }

  // Función para actualizar el filtro
  void filterActors() {
    setState(() {
      filteredActors = actors.where((actor) {
        final actorName = actor['name'].toLowerCase();
        final actorMovies = actor['movies'].join(' ').toLowerCase();
        final queryLower = searchQuery.toLowerCase();

        return actorName.contains(queryLower) ||
            actorMovies.contains(queryLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textColor =
        brightness == Brightness.dark ? Colors.white : Colors.black;

    return BaseScreen(
      onThemeChanged: widget.onThemeChanged,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      onFieldSubmitted: (value) {
                        filterActors(); // Filtrar cuando se envía el formulario
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa un término de búsqueda.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Buscar Actor/Película',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        filterActors(); //aplica filtro
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredActors.length,
              itemBuilder: (context, index) {
                final actor = filteredActors[index];
                return ActorCard(
                  actor: actor,
                  textColor: textColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActorDetailScreen(actor: actor),
                      ),
                    ).then((_) {
                      setState(() {
                        searchQuery = '';
                        filteredActors = actors;
                      });
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

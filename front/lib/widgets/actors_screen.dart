import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_base/models/actor.dart';
import 'package:flutter_application_base/screens/home_screen.dart';
import 'actor_card.dart';
import 'actor_detail.dart';
import 'package:http/http.dart' as http;

class ActorsListScreen extends StatefulWidget {
  final String apiUrl;
  final String screenTitle;
  final Function(bool) onThemeChanged;

  const ActorsListScreen({
    super.key,
    required this.apiUrl,
    required this.screenTitle,
    required this.onThemeChanged,
  });

  @override
  State<ActorsListScreen> createState() => _ActorsScreenState();
}

class _ActorsScreenState extends State<ActorsListScreen> {
  bool isLoading = true;
  /*
  List<Map<String, dynamic>> actors = [];
  List<Map<String, dynamic>> filteredActors = [];
  */
  List<Actor> actors = [];
  List<Actor> filteredActors = [];
  final _formKey = GlobalKey<FormState>();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchActors();
  }

  Future<void> fetchActors() async {
    final url = Uri.parse(widget.apiUrl);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          actors = List<Map<String, dynamic>>.from(responseData["data"])
          .map((json) => Actor.fromJson(json))
          .toList();
          filteredActors = actors;
          isLoading = false;
        });
      } else {
        throw Exception("Error al obtener actores");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar los actores: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void filterActors(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredActors = actors.where((actor) {
        final actorName = actor.name.toLowerCase();
        return actorName.contains(searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textColor = brightness == Brightness.dark ? Colors.white : Colors.black;

    return BaseScreen(
      onThemeChanged: widget.onThemeChanged,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                              searchQuery = value;
                            },
                            onFieldSubmitted: (value) {
                              if (_formKey.currentState!.validate()) {
                                filterActors(value);
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa un término de búsqueda.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Buscar Actor',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              filterActors(searchQuery);
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

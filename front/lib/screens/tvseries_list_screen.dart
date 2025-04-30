import 'package:flutter/material.dart';
import 'package:flutter_application_base/models/tvshows.dart';
import 'package:flutter_application_base/helpers/helpers.dart';
import 'package:flutter_application_base/screens/tvseries_detail_screen.dart';
import 'package:http/http.dart' as http;

class SeriesListScreen extends StatefulWidget {
  final String apiUrl;
  final String screenTitle;
  final Function(bool) onThemeChanged;

  const SeriesListScreen({
    super.key,
    required this.apiUrl,
    required this.screenTitle,
    required this.onThemeChanged,
  });

  @override
  State<SeriesListScreen> createState() => _SeriesListScreenState();
}

class _SeriesListScreenState extends State<SeriesListScreen> {
  bool isLoading = true;
 
  List<Series> series = [];
  List<Series> filteredSeries = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchSeries();
  }

  Future<void> fetchSeries() async {
    final url = Uri.parse(widget.apiUrl);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final seriesResponse = seriesFromJson(response.body);
        setState(() {
          series = seriesResponse.data;
          filteredSeries = seriesResponse.data;
          isLoading = false;
        });
      } else {
        throw Exception('Error al obtener las series');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar las series: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void filterSeries(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredSeries = series.where((serie) {
        final title = serie.name.toLowerCase();
        final genres = getGenres(serie.genreIds).toLowerCase();
        return title.contains(searchQuery) || genres.contains(searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textColor =
        brightness == Brightness.dark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.screenTitle),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    onChanged: (value) {
                      filterSeries(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Buscar por título o género',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredSeries.length,
                    itemBuilder: (context, index) {
                      final serie = filteredSeries[index];
                      final year = serie.firstAirDate.year.toString();
                      final genres = getGenres(serie.genreIds);

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: serie.posterPath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w200${serie.posterPath}",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        const Icon(Icons.image_not_supported),
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.cyan,
                                  child: Icon(Icons.movie, color: Colors.white),
                                ),
                          title: Text(
                            serie.name,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Puntuación: ${serie.voteAverage} | Votos: ${serie.voteCount}',
                                style:
                                    TextStyle(color: textColor, fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Año: $year | Género: $genres',
                                style:
                                    TextStyle(color: textColor, fontSize: 14),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SeriesDetailScreen(series: serie),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

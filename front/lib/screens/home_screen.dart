import 'package:flutter/material.dart';
import 'package:flutter_application_base/helpers/preferences.dart';
import 'package:flutter_application_base/models/profile_option.dart';
import 'package:flutter_application_base/screens/tvshows_screen.dart';
import 'package:flutter_application_base/screens/upcoming_movies_screen.dart';
import 'package:flutter_application_base/screens/actors_screen.dart';
import 'package:flutter_application_base/widgets/HoverProfile.dart';
import 'popular_movies_screen.dart';

// Estructura base para todas las pantallas
class BaseScreen extends StatelessWidget {
  final Widget body;
  final Function(bool) onThemeChanged;

  const BaseScreen({super.key, required this.body, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textColor = brightness == Brightness.dark ? Colors.white : Colors.black;

      return Scaffold(
        appBar: AppBar(
          backgroundColor: brightness == Brightness.dark ? Colors.black : Colors.cyan,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Cinéfilus ',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      drawer: Drawer(
        backgroundColor: brightness == Brightness.dark ? Colors.black : Colors.cyan,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: brightness == Brightness.dark ? Colors.black54 : Colors.cyan,
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: Text('Home', style: TextStyle(color: textColor)),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(onThemeChanged: onThemeChanged),
                  ),
                );
              },
            ),
            FutureBuilder<bool>(
              future: Preferences.getDarkMode(), // Usa FutureBuilder para cargar la preferencia
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator(); // Muestra un loader mientras se obtiene el dato
                return ListTile(
                  leading: const Icon(Icons.nightlight_round, color: Colors.white),
                  title: Text('Modo Oscuro', style: TextStyle(color: textColor)),
                  trailing: Switch(
                    value: snapshot.data ?? false,
                    onChanged: onThemeChanged,
                    activeColor: Colors.red,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}

// Pantalla principal (HomeScreen)
class HomeScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;

  const HomeScreen({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textColor = brightness == Brightness.dark ? Colors.white : Colors.black;

    final List<ProfileOption> profiles = [
      ProfileOption(
        image: 'assets/images/populares/destacados.png',
        name: 'Películas Populares',
        screen: PopularScreen(onThemeChanged: onThemeChanged),
      ),
      ProfileOption(
        image: 'assets/images/detalle/parasite.jpg',
        name: 'Mejores Series',
        screen: TvShowsScreen(onThemeChanged: onThemeChanged),
      ),
      ProfileOption(
        image: 'assets/images/clasicos/pulpfiction.jpg',
        name: 'Próximos estrenos',
        screen: UpcomingScreen(onThemeChanged: onThemeChanged),
      ),
      ProfileOption(
        image: 'assets/images/actores/mainactores.png',
        name: 'Mejores Actores',
        screen: ActorsScreen(onThemeChanged: onThemeChanged),
      ),
    ];

    return BaseScreen(
      onThemeChanged: onThemeChanged,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            "¿Qué deseas explorar?",
            style: TextStyle(fontSize: 20, color: textColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1,
              ),
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final profile = profiles[index];
                return HoverProfile(
                  image: profile.image,
                  name: profile.name,
                  textColor: textColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => profile.screen),
                    );
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

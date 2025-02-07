import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final Function(bool) toggleTheme;  // Recibimos la función para cambiar el tema.

  const DrawerMenu({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          // Agregar el Switch para cambiar el tema
          ListTile(
            title: const Text(
              'Cambiar Tema',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Switch(
              value: Theme.of(context).brightness == Brightness.dark,  // Verificamos si el tema actual es oscuro
              onChanged: (value) {
                toggleTheme(value);  // Llamamos a la función para cambiar el tema
              },
            ),
          ),
        ],
      ),
    );
  }
}

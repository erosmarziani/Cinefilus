import 'package:flutter/material.dart';

class AddMovieFormScreen extends StatefulWidget {
  @override
  _AddMovieFormScreenState createState() => _AddMovieFormScreenState();
}

class _AddMovieFormScreenState extends State<AddMovieFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _movieTitle = '';
  bool _isFeatured = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Película'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextFormField para el título
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Título de la película',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _movieTitle = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el título';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Switch para película destacada
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('¿Es una película destacada?'),
                  Switch(
                    value: _isFeatured,
                    onChanged: (value) {
                      setState(() {
                        _isFeatured = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Imagen principal
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    '../assets/images/populares/destacados.png',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Botón para guardar
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

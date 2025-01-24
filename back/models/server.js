const express = require('express');
const cors = require('cors');

class Server {
  constructor() {
    this.app = express();
    this.port = process.env.PORT || 3000;

    // Llamar a los métodos de configuración
    this.middleware();
    this.rutas();
  }

  middleware() {
    // Habilitar CORS para todas las rutas
    this.app.use(cors());
    // Middleware para servir contenido estático
    this.app.use(express.static('public'));
  }

  rutas() {
    // Rutas para diferentes endpoints
    this.app.use('/popular', require('../routes/popular')); // Rios Facundo
    this.app.use('/puntuados', require('../routes/puntuados')); // Bayon Marcos
    this.app.use('/api/v1/tv', require('../routes/tvShows')); // Hernandez Joaquin
    this.app.use('/upcoming', require('../routes/upcoming')); // Eros Marziani
  }

  listen() {
    this.app.listen(this.port, () => {
      console.log(`La API está escuchando en el puerto ${this.port}`);
    });
  }
}

module.exports = Server;

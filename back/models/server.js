const express = require('express')
const cors = require('cors');

class Server {
  constructor () {
    this.app = express()
    this.port = process.env.PORT || 4000
    this.middleware()
    this.rutas()
  }

  middleware () {
    this.app.use(cors());
    this.app.use(express.static('public'))
  }

  // 3 paso.
  // definimos la ruta -> es la que va ir en el navegador ->/peliculas
  rutas () {
    this.app.use('/api/v1/popular', require('../routes/popular')) 
    this.app.use('/api/v1/actors', require('../routes/actors')) 
    this.app.use('/api/v1/tv', require('../routes/tvShows')) 
    this.app.use('/api/v1/upcoming', require('../routes/upcoming')) 
  }

  listen () {
    this.app.listen(this.port, () => {
      console.log(`La API está escuchando en el puerto ${this.port}`)
    })
  }
}

module.exports = Server

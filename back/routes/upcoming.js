const { Router } = require('express')
const {getAllUpcomingMovies, getUpcomingMoviePorID  } = require('../controllers/upcoming') // Ajustar la ruta de importación en caso que sea necesario.

const rutas = Router()

//Rutas Eros
rutas.get('/', getAllUpcomingMovies)
rutas.get('/:id', getUpcomingMoviePorID)

module.exports = rutas

const { Router } = require('express')
const {getAllUpcomingMovies, getUpcomingMoviePorID, getUpcomingMoviesWithFilters  } = require('../controllers/upcoming_movies') // Ajustar la ruta de importación en caso que sea necesario.

const rutas = Router()

//Rutas Eros
rutas.get('/', getAllUpcomingMovies)
rutas.get('/:id', getUpcomingMoviePorID)
rutas.get('/filter', getUpcomingMoviesWithFilters)


module.exports = rutas

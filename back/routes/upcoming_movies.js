const { Router } = require('express')
const {getAllUpcomingMovies, getUpcomingMoviePorID, getUpcomingMoviesWithFilters  } = require('../controllers/upcoming_movies') // Ajustar la ruta de importación en caso que sea necesario.

const rutas = Router()

//  2 paso
// definir ruta -> aun no se entiende el objetivo de esto.
rutas.get('/', getAllUpcomingMovies)

rutas.get('/:id', getUpcomingMoviePorID)

rutas.get('/filter', getUpcomingMoviesWithFilters)


module.exports = rutas

const { Router } = require('express')
const { getAllPopularMovies, getMovieImages } = require('../controllers/popular')

const rutas = Router()

//  2 paso
// definir ruta -> aun no se entiende el objetivo de esto.
rutas.get('/', getAllPopularMovies)
// trae imagenes de las peliculas segun id
rutas.get('/:id', getMovieImages)

module.exports = rutas

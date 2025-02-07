const { Router } = require('express')
const { getAllPopularMovies } = require('../controllers/popular')

const rutas = Router()

//  2 paso
// definir ruta -> aun no se entiende el objetivo de esto.
rutas.get('/', getAllPopularMovies)
module.exports = rutas

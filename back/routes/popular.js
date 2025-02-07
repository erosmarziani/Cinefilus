const { Router } = require('express')
const { getAllPopularMovies } = require('../controllers/popular')

const rutas = Router()

rutas.get('/', getAllPopularMovies)
module.exports = rutas

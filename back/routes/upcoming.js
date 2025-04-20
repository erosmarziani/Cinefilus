const { Router } = require('express')
const { getAllUpcomingMovies } = require('../controllers/upcoming') // Ajustar la ruta de importación en caso que sea necesario.

const rutas = Router()

rutas.get('/', getAllUpcomingMovies)

module.exports = rutas

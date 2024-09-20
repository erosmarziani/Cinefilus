const { Router } = require('express')
const { getAllPeliculas } = require('../controllers/peliculas') // Ajustar la ruta de importación en caso que sea necesario.

const rutas = Router()

//  2 paso
// definir ruta -> aun no se entiende el objetivo de esto.
rutas.get('/', getAllPeliculas)

module.exports = rutas

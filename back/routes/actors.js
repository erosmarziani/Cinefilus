const { Router } = require('express')
const {getAllActors} = require('../controllers/actors') // Ajustar la ruta de importación en caso que sea necesario.

const rutas = Router()

//Ruta para obtener actores en tendencia
rutas.get('/', getAllActors)

module.exports = rutas

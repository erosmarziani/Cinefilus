const { Router } = require('express')
const {getAllGeneros,getGeneroPorID } = require('../controllers/generos') // Ajustar la ruta de importación en caso que sea necesario.

const rutas = Router()

//  2 paso
// definir ruta -> aun no se entiende el objetivo de esto.
rutas.get('/', getAllGeneros)

//Ruta para buscar genero por id
rutas.get('/:id', getGeneroPorID)
module.exports = rutas

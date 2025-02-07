const express = require('express')
const { getAllTrendingTVShows } = require('../controllers/tvShows')

const router = express.Router()

// Ruta para obtener programas de TV en tendencia
router.get('/trending/:timeWidow', getAllTrendingTVShows)



module.exports = router

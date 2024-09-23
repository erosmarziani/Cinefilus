const express = require('express');
const { getTrendingTVShows, getTVShowByID, getTrendingTVShowsByPage } = require('../controllers/tvShows');

const router = express.Router();

// Ruta para obtener programas de TV en tendencia
router.get('/trending/:time_window', getTrendingTVShows);

// Ruta para obtener un programa de TV por su ID
router.get('/:id', getTVShowByID);

// Nueva ruta para obtener programas de TV por página
router.get('/trending/:time_window', getTrendingTVShowsByPage); ///trending/:time_window/page

module.exports = router;
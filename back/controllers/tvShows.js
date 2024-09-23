const axios = require('axios');
const { API_KEY, BASE_URL } = require('../constants/constants');

// Método para obtener 50 o más programas de TV en tendencia
//http://localhost:3000/api/v1/tv/trending/week
const getTrendingTVShows = async (req, res) => {
    try {
        const { time_window = 'week' } = req.params;

        // Realizar solicitudes a múltiples páginas
        const requests = [
            axios.get(`${BASE_URL}/trending/tv/${time_window}?api_key=${API_KEY}&page=1`),
            axios.get(`${BASE_URL}/trending/tv/${time_window}?api_key=${API_KEY}&page=2`),
            axios.get(`${BASE_URL}/trending/tv/${time_window}?api_key=${API_KEY}&page=3`)
        ];

        // Esperar todas las solicitudes
        const responses = await Promise.all(requests);

        // Combinar los resultados (más de 50)
        const allResults = responses.flatMap(response => response.data.results);

        return res.status(200).json({
            msg: 'Programas de TV en tendencia obtenidos correctamente',
            data: allResults
        });
    } catch (error) {
        console.error('Error al obtener los programas de TV en tendencia:', error.message);
        return res.status(500).json({
            msg: 'Error al obtener los programas de TV en tendencia',
            error: error.message
        });
    }
};

// Obtener programa de TV por ID
//http://localhost:3000/api/v1/tv/194764
const getTVShowByID = async (req, res = response) => {
    try {
        const tv_id = req.params.id;
        const URL = `${BASE_URL}/tv/${tv_id}?api_key=${API_KEY}`;

        const { data } = await axios.get(URL);

        // Filtrar solo la información que necesitas
        const filteredData = {
            id: data.id,
            name: data.name,
            overview: data.overview,
            genres: data.genres.map(genre => genre.name),
            seasons: data.seasons.length,
            first_air_date: data.first_air_date,
            status: data.status,
            vote_average: data.vote_average
        };

        return res.status(200).json({
            msg: 'Programa de TV obtenido correctamente',
            data: filteredData
        });
    } catch (error) {
        console.error('Error al obtener el programa de TV por ID:', error.message);
        return res.status(500).json({
            msg: 'Error al obtener el programa de TV por ID',
            error: error.message
        });
    }
};

// Método para obtener programas de TV en tendencia por página
//http://localhost:3000/api/v1/tv/trending/week?page=2
//revisar aca 
const getTrendingTVShowsByPage = async (req, res) => {
    try {
        const { time_window = 'week' } = req.params;
        const { page = 2 } = req.query; // Parámetro de página

        const URL = `${BASE_URL}/trending/tv/${time_window}?api_key=${API_KEY}&page=${page}`;
        const { data } = await axios.get(URL);

        return res.status(200).json({
            msg: `Programas de TV en tendencia - Página ${page}`,
            data: data.results
        });
    } catch (error) {
        console.error('Error al obtener los programas de TV en tendencia por página:', error.message);
        return res.status(500).json({
            msg: 'Error al obtener los programas de TV en tendencia por página',
            error: error.message
        });
    }
};



module.exports = {
    getTrendingTVShows,
    getTVShowByID,
    getTrendingTVShowsByPage

};
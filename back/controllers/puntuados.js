// controlador.js
const axios = require('axios')
const { request, response } = require('express')
const { BASE_URL, API_KEY } = require('../constants/constants')

// 1er paso definir el metodo y hacer la request.
// Metodo para obtener todas las películas
const getPuntuados = async (req = request, res = response) => {
  try {
    const URL = `${BASE_URL}movie/top_rated?api_key=${API_KEY}` // Construir la URL con la API key

    // Realizar la petición a la API
    const { data } = await axios.get(URL)

    // Filtrar solo los campos `vote_count` , `vote_average` , `title` y `id`
    const filteredMovies = data.results.map(movie => ({
        title: movie.title,
        id: movie.id,
        vote_count: movie.vote_count,
        vote_average: movie.vote_average
      }));
  
      // Enviar la respuesta con los datos filtrados
      return res.status(200).json({
        msg: 'Puntajes obtenidos correctamente',
        data: filteredMovies
      });
  } catch (error) {
// Manejo de errores
    console.error('Error al obtener los puntajes:', error.message);

    return res.status(500).json({
      msg: 'Error al obtener puntajes',
      error: error.message
    });
  }
}

// 2. Buscar una película mejor puntuada por su ID
const getPuntuadoById = async (req = request, res = response) => {
    const { id } = req.params; // Obtener el ID de los parámetros de la URL
  
    try {
      const URL = `${BASE_URL}movie/${id}?api_key=${API_KEY}`;
  
      // Realizar la petición a la API para obtener la película por ID
      const { data } = await axios.get(URL);
  
      // Filtrar solo los campos `vote_count` y `vote_average`
      const movieData = {
        title: data.title,
        id: data.id,
        vote_count: data.vote_count,
        vote_average: data.vote_average
      };
  
      // Enviar la respuesta con los datos filtrados
      return res.status(200).json({
        msg: 'Película obtenida correctamente',
        data: movieData
      });
    } catch (error) {
      // Manejo de errores
      console.error(`Error al obtener la película con ID ${id}:`, error.message);
  
      return res.status(500).json({
        msg: `Error al obtener la película con ID ${id}`,
        error: error.message
      });
    }
  };
  

// exportamos la request que hicimos.
module.exports = {
  getPuntuados,
  getPuntuadoById
}

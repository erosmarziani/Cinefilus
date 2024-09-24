// controlador.js
const axios = require('axios')
const { request, response } = require('express')
const { BASE_URL, API_KEY } = require('../constants/constants')


// 1. Buscar 50 peliculas puntuadas.
const getPuntuados = async (req = request, res = response) => {
  try {

    //Calcular cantidad de paginas que tendria que ver para obtener hasta 50 peliculas
    const resultsPerPage = 20; // Peliculas por pagina
    const totalMovies = 50; // Cantidad de peliculas que queremos obtener
    const totalPages = Math.ceil(totalMovies / resultsPerPage); // Número de painas a consultar

    let allMovies = [];

    // Realizar peticiones a las paginas necesarias para obtener 50 peliculas
    for (let page = 1; page <= totalPages; page++) {
      const URL = `${BASE_URL}/movie/top_rated?api_key=${API_KEY}&page=${page}`;
      console.log(URL);
      const { data } = await axios.get(URL);
      console.log(data);

      // Añadir las películas obtenidas en la lista general
      allMovies = allMovies.concat(data.results);
    }

    console.log(allMovies);
    // Filtrar solo los campos `title` , `id` , `vote_count` y `vote_average`
    const filteredMovies = allMovies.slice(0, totalMovies).map(movie => ({
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
};

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

// 3. Buscar 50 peliculas puntuadas por idioma
const getPuntuadosByLanguage = async (req = request, res = response) => {
  const baseUrl = `${BASE_URL}movie/top_rated`;
  const { language = 'en-US' } = req.query; // Obtener el parámetro de idioma (por defecto 'en-US')

  try {
    const response = await axios.get(baseUrl, {
      params: {
        api_key: API_KEY,
        language, // Idioma proporcionado o 'en-US' por defecto
        page: 1,  // Página 1 por defecto
      },
    });

    // Enviar la respuesta con las películas en el idioma solicitado
    res.status(200).json({
      msg: `Películas en ${language}`,
      data: response.data.results,
    });
  } catch (error) {
    console.error('Error al obtener películas por idioma:', error.message);
    res.status(400).json({
      msg: 'Error al obtener películas por idioma',
      error: error.message,
    });
  }
};

// exportamos la request que hicimos.
module.exports = {
  getPuntuados,
  getPuntuadoById,
  getPuntuadosByLanguage
}

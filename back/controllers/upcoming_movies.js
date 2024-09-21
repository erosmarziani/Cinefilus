// controlador.js
const axios = require('axios')
const { request, response } = require('express')
const { API_KEY, UPCOMING_MOVIES_URL } = require('../constants/constants')

// 1er paso definir el metodo y hacer la request.
// Metodo para obtener todas las películas
const getAllUpcomingMovies = async (req = request, res = response) => {
  try {
    const URL = `${UPCOMING_MOVIES_URL}?api_key=${API_KEY}` // Construir la URL con la API key

    // Realizar la petición a la API
    const { data } = await axios.get(URL)

    // Enviar la respuesta con los datos obtenidos
    return res.status(200).json({
      msg: 'Peliculas proximas a estrenar obtenidas correctamente',
      data
    })
  } catch (error) {
    // Manejo de errores
    console.error('Error al obtener las peliculas proximas a estrenar:', error.message)

    return res.status(500).json({
      msg: 'Error al obtener las peliculas proximas a estrenar',
      error: error.message
    })
  }
}

const getUpcomingMoviePorID = async (req = request, res = response) => {
    try {
      const upcomingID = req.params.id; // Aquí obtienes el ID de la URL
  
      // En lugar de hacer una petición a un URL incorrecto, busca los géneros primero
      const URL = `${UPCOMING_MOVIES_URL}?api_key=${API_KEY}`;
      
      // Realizar la petición a la API para obtener todos los géneros
      const { data } = await axios.get(URL);
      const allUpcomingMovies = data.results; // Asumimos que 'data' tiene la propiedad 'genres'
  
      // Buscar el género por ID
      const upcomingMovie = allUpcomingMovies.find(g => g.id === parseInt(upcomingID)); // Asegúrate de comparar como número
  
      if (upcomingMovie) {
        return res.status(200).json({
          msg: 'Pelicula a estrenar obtenida correctamente',
          data: upcomingMovie // Envía el género encontrado
        });
      } else {
        return res.status(404).json({
          msg: 'Pelicula a estrenar no encontrada',
          error: 'No existe una pelicula a estrenar con este ID'
        });
      }
    } catch (error) {
      // Manejo de errores
      console.error('Error al obtener la pelicula a estrenar:', error.message);
  
      return res.status(500).json({
        msg: 'Error al obtener la pelicula a estrenar',
        error: error.message
      });
    }
  }

  const getUpcomingMoviesWithFilters = async (req = request, res = response) => {
      try{
        const URL = `${UPCOMING_MOVIES_URL}?api_key=${API_KEY}`;

        const { data } = await axios.get(URL);
        let allUpcomingMovies = data.results; 

        //Filtrar por clasificacion de edad
        if (req.query.adult !== undefined) { // Verifica si el parámetro está presente
            const isAdult = req.query.adult === 'true'; // Convertir a booleano
            allUpcomingMovies = allUpcomingMovies.filter(movie => movie.adult === isAdult);
          }
          
        //Filtrar por idioma
        if(req.query.original_language){
            allUpcomingMovies = allUpcomingMovies.filter(movie => movie.original_language === req.query.original_language);
        }

        return res.status(200).json({
            msg: 'Peliculas a estrenar filtradas correctamente',
            data: allUpcomingMovies
        });
    }catch(error){
        console.error('Error al filtrar las peliculas a estrenar:', error.message);

        return res.status(500).json({
            msg: 'Error al filtrar las peliculas a estrenar',
            error: error.message
        });
    }
  }
  

// exportamos la request que hicimos.
module.exports = {
 getAllUpcomingMovies,
 getUpcomingMoviePorID,
 getUpcomingMoviesWithFilters
}

const axios = require('axios')
const { request, response } = require('express')
const { BASE_URL, API_KEY } = require('../constants/constants')

// Metodo para obtener todas las películas
const getAllUpcomingMovies = async (req = request, res = response) => {
  const { lang, page = 1, adult } = req.query

  const params = 'movie/upcoming'
  let allMovies = []
  let currentPage = page

  try { 
    while (allMovies.length < 50 ) {
      let URL = `${BASE_URL}/${params}?api_key=${API_KEY}&page=${currentPage}` // Construir la URL con la API key

      if (lang) {
        URL += `&language=${lang}`
      }
      if (adult) {
        URL += `&include_adult=${adult}`
      }
      
      const { data } = await axios.get(`${URL}&page=${currentPage}`)
      
      if (!data || !data.results || data.results.length === 0) {
          break;
      } 

      allMovies = allMovies.concat(data.results) // Agregar resultados a la lista
      currentPage++ // Incrementar el número de página para la siguiente iteración
    }

  
    // Enviar la respuesta con los datos obtenidos
    return res.status(200).json({
      msg: 'Peliculas proximas a estrenar obtenidas correctamente',
      data: allMovies
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

// exportamos la request que hicimos.
module.exports = {
  getAllUpcomingMovies
}

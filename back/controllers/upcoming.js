const axios = require('axios')
const { request, response } = require('express')
const { BASE_URL, API_KEY } = require('../constants/constants')

// Metodo para obtener todas las películas
const getAllUpcomingMovies = async (req = request, res = response) => {
  const { lang, page = 1, adult } = req.query

  const params = 'movie/upcoming'
  const totalPeliculas = 50
  let listaPeliculasProximas = []
  let currentPage = page

  try {
    while (listaPeliculasProximas.length < totalPeliculas) {
      let URL = `${BASE_URL}/${params}?api_key=${API_KEY}&page=${currentPage}` // Construir la URL con la API key
      if (lang) {
        URL += `&language=${lang}`
      }

      if (adult) {
        URL += `&include_adult=${adult}`
      }

      const { data } = await axios.get(`${URL}&page=${currentPage}`)

      listaPeliculasProximas = listaPeliculasProximas.concat(data.results) // Agregar resultados a la lista
      currentPage++ // Incrementar el número de página para la siguiente iteración
    }

    // Asegurarse de devolver al menos 50 películas
    if (listaPeliculasProximas.length < totalPeliculas) {
      return res.status(404).json({
        msg: 'No se encontraron suficientes películas a estrenar.',
        data: listaPeliculasProximas
      })
    }
    // Enviar la respuesta con los datos obtenidos
    return res.status(200).json({
      msg: 'Peliculas proximas a estrenar obtenidas correctamente',
      data: listaPeliculasProximas
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

// BUsca la pelicula proxima a estrenar por el ID
const getUpcomingMoviePorID = async (req = request, res = response) => {
  const params = 'movie/upcoming'
  const upcomingID = req.params.id

  try {
    // En lugar de hacer una petición a un URL incorrecto, busca los géneros primero
    const URL = `${BASE_URL}/${params}?api_key=${API_KEY}`

    // Realizar la petición a la API para obtener todos los géneros
    const { data } = await axios.get(URL)
    const allUpcomingMovies = data.results // Asumimos que 'data' tiene la propiedad 'genres'

    // Buscar el género por ID
    const upcomingMovie = allUpcomingMovies.find(g => g.id === parseInt(upcomingID)) // Asegúrate de comparar como número

    if (upcomingMovie) {
      return res.status(200).json({
        msg: 'Pelicula a estrenar obtenida correctamente',
        data: upcomingMovie // Envía el género encontrado
      })
    } else {
      return res.status(404).json({
        msg: 'Pelicula a estrenar no encontrada',
        error: 'No existe una pelicula a estrenar con este ID'
      })
    }
  } catch (error) {
    // Manejo de errores
    console.error('Error al obtener la pelicula a estrenar:', error.message)

    return res.status(500).json({
      msg: 'Error al obtener la pelicula a estrenar',
      error: error.message
    })
  }
}

// exportamos la request que hicimos.
module.exports = {
  getAllUpcomingMovies,
  getUpcomingMoviePorID
}

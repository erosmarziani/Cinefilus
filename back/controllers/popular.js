const axios = require('axios')
const { request, response } = require('express')

// Función para obtener todas las películas populares con un solo filtro
const getAllPopularMovies = async (req = request, res = response) => {
  const { lang, page = 1, year } = req.query

  const params = 'movie/popular'
  let allMovies = []
  let currentPage = page

  try {
    // Aplicamos un while para obtener al menos 50 películas mediante paginación
    while (allMovies.length < 50) {
      let URL = `${process.env.BASE_URL}/${params}?api_key=${process.env.API_KEY}&page=${currentPage}`

      // Si se proporciona algún parámetro de filtro, lo agregamos a la URL
      if (lang) {
        URL += `&language=${lang}`
      }
      if (year) {
        URL += `&primary_release_year=${year}`
      }

      // Realizamos la petición a la API
      const { data } = await axios.get(URL)

      // Verificamos si hay resultados en la página
      if (!data || !data.results || data.results.length === 0) {
        break // Si no hay más resultados, salimos del bucle
      }

      // Agregamos las películas obtenidas a la lista total
      allMovies = allMovies.concat(data.results)
      currentPage++ // Pasamos a la siguiente página
    }

    // Limitamos la cantidad de películas a 50
    allMovies = allMovies.slice(0, 50)

    return res.status(200).json({
      msg: `Películas obtenidas correctamente (${allMovies.length} registros)`,
      data: allMovies
    })
  } catch (error) {
    console.error('Error al obtener las películas:', error.message)
    return res.status(500).json({
      msg: 'Error al obtener las películas',
      error: error.message
    })
  }
}
/*
//  obtener imágenes de una película por movie_id
const getMovieImages = async (req = request, res = response) => {
  const { id } = req.params
  const params = `movie/${id}/images`

  try {
    const URL = `${BASE_URL}/${params}?api_key=${API_KEY}`
    const { data } = await axios.get(URL)

    // Verificamos si hay imágenes
    if (!data || (!data.backdrops && !data.posters)) {
      return res.status(404).json({
        msg: 'No se encontraron imágenes para esta película',
        data: {}
      })
    }

    return res.status(200).json({
      msg: 'Imágenes obtenidas correctamente',
      backdrops: data.backdrops,
      posters: data.posters
    })
  } catch (error) {
    console.error('Error al obtener las imágenes:', error.message)
    return res.status(500).json({
      msg: 'Error al obtener las imágenes',
      error: error.message
    })
  }
}
  */

// Exportamos la función
module.exports = {
  getAllPopularMovies}

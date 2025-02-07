const axios = require('axios')
const { request, response } = require('express')
const { API_KEY, BASE_URL } = require('../constants/constants')

const getAllTrendingTVShows = async (req = request, res = response) => {
  
    // Se usa req.query para obtener parámetros opcionales
    const { timeWindow = 'week', page = 1 } = req.query ;

    const params = `trending/tv/${timeWindow}`
    let allTvShows = []
    let currentPage = page 

    try{
    while (allTvShows.length < 50) {
      let URL = `${BASE_URL}/${params}?api_key=${API_KEY}&page=${currentPage}`

      const { data } = await axios.get(URL)

      if (!data || !data.results || data.results.length === 0) {
        break // Si no hay más resultados, se detiene el ciclo
      }

      allTvShows = allTvShows.concat(data.results)
      currentPage++
    }

    return res.status(200).json({
      msg: 'Programas de TV en tendencia obtenidos correctamente',
      data: allTvShows
    })
  } catch (error) {
    console.error('Error al obtener los programas de TV en tendencia:', error.message)
    return res.status(500).json({
      msg: 'Error al obtener los programas de TV en tendencia',
      error: error.message
    })
  }
}

module.exports = { getAllTrendingTVShows }

/*
// Obtener programa de TV por ID
// http://localhost:3000/api/v1/tv/194764
const getTVShowByID = async (req, res) => {
  try {
    const tvId = req.params.id
    const URL = `${BASE_URL}/tv/${tvId}?api_key=${API_KEY}`

    const { data } = await axios.get(URL)

    // Filtrar solo la información que necesitas
    const filteredData = {
      id: data.id,
      name: data.name,
      overview: data.overview,
      genres: data.genres.map((genre) => genre.name),
      seasons: data.seasons.length,
      first_air_date: data.first_air_date,
      status: data.status,
      vote_average: data.vote_average
    }

    return res.status(200).json({
      msg: 'Programa de TV obtenido correctamente',
      data: filteredData
    })
  } catch (error) {
    console.error('Error al obtener el programa de TV por ID:', error.message)
    return res.status(500).json({
      msg: 'Error al obtener el programa de TV por ID',
      error: error.message
    })
  }
}

// Método para obtener programas de TV en tendencia por página
// http://localhost:3000/api/v1/tv/trending/week?page=2
// revisar aca
const getTrendingTVShowsByPage = async (req, res) => {
  try {
    const { timeWidow = 'week' } = req.params
    const { page = 2 } = req.query // Parámetro de página

    const URL = `${BASE_URL}/trending/tv/${timeWidow}?api_key=${API_KEY}&page=${page}`
    const { data } = await axios.get(URL)

    return res.status(200).json({
      msg: `Programas de TV en tendencia - Página ${page}`,
      data: data.results
    })
  } catch (error) {
    console.error(
      'Error al obtener los programas de TV en tendencia por página:',
      error.message
    )
    return res.status(500).json({
      msg: 'Error al obtener los programas de TV en tendencia por página',
      error: error.message
    })
  }
}
  */

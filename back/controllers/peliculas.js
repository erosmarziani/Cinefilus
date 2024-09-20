// controlador.js
const axios = require('axios')
const { request, response } = require('express')
const { BASE_URL, API_KEY } = require('../constants/constants')

// 1er paso definir el metodo y hacer la request.
// Metodo para obtener todas las películas
const getAllPeliculas = async (req = request, res = response) => {
  try {
    const URL = `${BASE_URL}?api_key=${API_KEY}` // Construir la URL con la API key

    // Realizar la petición a la API
    const { data } = await axios.get(URL)

    // Enviar la respuesta con los datos obtenidos
    return res.status(200).json({
      msg: 'Películas obtenidas correctamente',
      data
    })
  } catch (error) {
    // Manejo de errores
    console.error('Error al obtener las películas:', error.message)

    return res.status(500).json({
      msg: 'Error al obtener las películas',
      error: error.message
    })
  }
}

const getPeliculaPorID = async (req = request, res = response) => {
  try {
    const { id } = req.params
    const URL = `${BASE_URL}/${id}?api_key=${API_KEY}`

    // Realizar la petición a la API
    const { data } = await axios.get(URL)

    // Enviar la respuesta con los datos obtenidos
    return res.status(200).json({
      msg: 'Pelicula obtenida correctamente',
      data
    })
  } catch (error) {
    // Manejo de errores
    return res.status(500).json({
      msg: 'Error al obtener la pelicula',
      error: error.message
    })
  }
    }

// exportamos la request que hicimos.
module.exports = {
  getAllPeliculas
, getPeliculaPorID
}

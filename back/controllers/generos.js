// controlador.js
const axios = require('axios')
const { request, response } = require('express')
const { BASE_URL, API_KEY, GENEROS_URL } = require('../constants/constants')

// 1er paso definir el metodo y hacer la request.
// Metodo para obtener todas las películas
const getAllGeneros = async (req = request, res = response) => {
  try {
    const URL = `${GENEROS_URL}?api_key=${API_KEY}` // Construir la URL con la API key

    // Realizar la petición a la API
    const { data } = await axios.get(URL)

    // Enviar la respuesta con los datos obtenidos
    return res.status(200).json({
      msg: 'Generos obtenidas correctamente',
      data
    })
  } catch (error) {
    // Manejo de errores
    console.error('Error al obtener los generos:', error.message)

    return res.status(500).json({
      msg: 'Error al obtener los generos',
      error: error.message
    })
  }
}


// exportamos la request que hicimos.
module.exports = {
 getAllGeneros
}

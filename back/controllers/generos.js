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

const getGeneroPorID = async (req = request, res = response) => {
    try {
      const genreId = req.params.id; // Aquí obtienes el ID de la URL
  
      // En lugar de hacer una petición a un URL incorrecto, busca los géneros primero
      const URL = `${GENEROS_URL}?api_key=${API_KEY}`;
      
      // Realizar la petición a la API para obtener todos los géneros
      const { data } = await axios.get(URL);
      const genres = data.genres; // Asumimos que 'data' tiene la propiedad 'genres'
  
      // Buscar el género por ID
      const genero = genres.find(g => g.id === parseInt(genreId)); // Asegúrate de comparar como número
  
      if (genero) {
        return res.status(200).json({
          msg: 'Género obtenido correctamente',
          data: genero // Envía el género encontrado
        });
      } else {
        return res.status(404).json({
          msg: 'Género no encontrado',
          error: 'No existe un género con este ID'
        });
      }
    } catch (error) {
      // Manejo de errores
      console.error('Error al obtener el género:', error.message);
  
      return res.status(500).json({
        msg: 'Error al obtener el género',
        error: error.message
      });
    }
  }
  


// exportamos la request que hicimos.
module.exports = {
 getAllGeneros,
 getGeneroPorID
}

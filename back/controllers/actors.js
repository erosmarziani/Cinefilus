const axios = require('axios')
const { request, response } = require('express')

const getAllActors = async (req = request, res = response) => {

  const { timeWindow = 'week', page = 1 } = req.query;
  const params = `trending/person/${timeWindow}`
  let allActors = []
  let currentPage = page

  try {

    while (allActors.length < 50) {
      
      let URL = `${process.env.BASE_URL}/${params}?api_key=${process.env.API_KEY}&page=${currentPage}` // Construir la URL con la API key

      const { data } = await axios.get(URL)
      if (!data || !data.results || data.results.length === 0) {
        break;
      }
      allActors = allActors.concat(data.results) // Agregar resultados a la lista
      currentPage++ // Incrementar el número de página para la siguiente iteración
    }
    // Enviar la respuesta con los datos filtrados
    return res.status(200).json({
      msg: 'Actores obtenidos correctamente',
      data: allActors
    })
  } catch (error) {
    // Manejo de errores
    console.error('Error al obtener los actores:', error.message)

    return res.status(500).json({
      msg: 'Error al obtener actores',
      error: error.message
    })
  }
}

// Buscar actor por id
/*const getActorbyId = async (req = request, res = response) => {
try{
  const actorId = parseInt(req.params.actorId);
    const { timeWindow = 'week'} = req.query;
  const URL = `${BASE_URL}/trending/person/${timeWindow}?api_key=${API_KEY}`

    // Realizar la petición a la API para obtener la película por ID
    const { data } = await axios.get(URL)

    const actor = data.results.find(person => person.id === actorId)

    // Enviar la respuesta con los datos filtrados
    return res.status(200).json({
      msg: 'Actor obtenido correctamente',
      data: actor
    })
  } catch (error) {
    // Manejo de errores
    console.error(`Error al obtener el actor con el id: ${actorId}:`, error.message)

    return res.status(500).json({
      msg: `Error al obtener el actor con ID: ${actorId}`,
      error: error.message
    })
  }
}
  */

// exportamos la request que hicimos.
module.exports = {
  getAllActors
}

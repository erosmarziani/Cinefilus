// controlador.js
const axios = require("axios");
const { request, response } = require("express");
const { BASE_URL, API_KEY } = require("../constants/constants");

// 1er paso definir el metodo y hacer la request.
// Metodo para obtener todas las películas
const getAllPeliculas = async (req = request, res = response) => {
  try {
    const URL = `${BASE_URL}?api_key=${API_KEY}`; // Construir la URL con la API key

    // Realizar la petición a la API
    const { data } = await axios.get(URL);

    // Enviar la respuesta con los datos obtenidos
    return res.status(200).json({
      msg: "Películas obtenidas correctamente",
      data,
    });
  } catch (error) {
    // Manejo de errores
    console.error("Error al obtener las películas:", error.message);

    return res.status(500).json({
      msg: "Error al obtener las películas",
      error: error.message,
    });
  }
};

const getAllUpcomingMovies = async (req = request, res = response) => {
  const params = "movie/upcoming";
  try {
    const URL = `${BASE_URL}/${params}?api_key=${API_KEY}`;


    const { data } = await axios.get(URL);

    console.log("URL construida:", URL);
    console.log("Datos completos:", data); // Log completo de la respuesta
    console.log("Resultados de películas:", data.results); // Log específico de resultados

    if (!data || !data.results || data.results.length === 0) {
      return res.status(404).json({
        msg: "No se encontraron próximas películas",
        data: [],
      });
    }

    return res.status(200).json({
      msg: "Películas obtenidas correctamente",
      data: data.results, // Enviar solo los resultados
    });
  } catch (error) {
    console.error("Error al obtener las películas:", error.message);
    return res.status(500).json({
      msg: "Error al obtener las películas",
      error: error.message,
    });
  }
};

// exportamos la request que hicimos.
module.exports = {
  getAllPeliculas,
  getAllUpcomingMovies,
};

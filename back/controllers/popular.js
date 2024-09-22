const axios = require("axios");
const { request, response } = require("express");
const { BASE_URL, API_KEY } = require("../constants/constants");

// Función para obtener todas las películas populares con un mínimo de 50 registros
const getAllPopularMovies = async (req = request, res = response) => {
  const params = "movie/popular";
  let allMovies = [];
  let page = 1; // Iniciamos en la página 1

  try {
    while (allMovies.length < 50) {
      const URL = `${BASE_URL}/${params}?api_key=${API_KEY}&page=${page}`;
      const { data } = await axios.get(URL);

      console.log(`URL construida para la página ${page}:`, URL);
      console.log("Datos completos:", data);
      console.log("Resultados de películas:", data.results);

      // Verifica si hay resultados en la página
      if (!data || !data.results || data.results.length === 0) {
        break; // Si no hay más resultados, salimos del bucle
      }

      // Agregamos las películas obtenidas a la lista total
      allMovies = allMovies.concat(data.results);
      page++; // Pasamos a la siguiente página
    }

    // Limitamos la cantidad de películas a 50, si hay más
    allMovies = allMovies.slice(0, 50);

    return res.status(200).json({
      msg: `Películas obtenidas correctamente (${allMovies.length} registros)`,
      data: allMovies, // Devolver solo los resultados
    });
  } catch (error) {
    console.error("Error al obtener las películas:", error.message);
    return res.status(500).json({
      msg: "Error al obtener las películas",
      error: error.message,
    });
  }
};

// Controlador para obtener imágenes de una película por movie_id
const getMovieImages = async (req = request, res = response) => {
  const { id } = req.params; // Obtenemos el movie_id de los parámetros de la URL
  const params = `movie/${id}/images`;

  try {
    // Construimos la URL con el movie_id y la API key
    const URL = `${BASE_URL}/${params}?api_key=${API_KEY}`;
    console.log(URL);

    // Hacemos la petición a la API
    const { data } = await axios.get(URL);

    console.log("URL construida:", URL);
    console.log("Datos completos:", data); // Log completo de la respuesta

    // Verificamos si hay imágenes
    if (!data || (!data.backdrops && !data.posters)) {
      return res.status(404).json({
        msg: "No se encontraron imágenes para esta película",
        data: {},
      });
    }

    return res.status(200).json({
      msg: "Imágenes obtenidas correctamente",
      backdrops: data.backdrops, // Enviar solo los backdrops
      posters: data.posters, // Enviar solo los posters
    });
  } catch (error) {
    console.error("Error al obtener las imágenes:", error.message);
    return res.status(500).json({
      msg: "Error al obtener las imágenes",
      error: error.message,
    });
  }
};

// Exportamos la función
module.exports = {
  getAllPopularMovies,
  getMovieImages,
};

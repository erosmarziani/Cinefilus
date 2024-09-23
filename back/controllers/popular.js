const axios = require("axios");
const { request, response } = require("express");
const { BASE_URL, API_KEY } = require("../constants/constants");

const getAllPopularMovies = async (req = request, res = response) => {
  //defino pagina por default y desestructuro
  const { lang, page = 1, year, order } = req.query;

  const params = "movie/popular";
  let allMovies = [];
  let currentPage = page;

  try {
    //aplico un while porq la api no tiene para un filtro para traer x cant de resultados, solo paginacion.
    while (allMovies.length < 50) {
      // Construimos la URL con el parámetro page y el API key
      let URL = `${BASE_URL}/${params}?api_key=${API_KEY}&page=${currentPage}`;

      // Si se proporciona algún parámetro de filtro, lo agregamos a la URL
      if (lang) {
        URL += `&language=${lang}`;
      } else if (year) {
        URL += `&primary_release_year=${year}`;
      } else if (order) {
        // Si el orden es especificado, luego se aplicará después de la obtención
      }

      // Realizamos la petición a la API
      const { data } = await axios.get(URL);

      // Verificamos si hay resultados en la página
      if (!data || !data.results || data.results.length === 0) {
        break; // Si no hay más resultados, salimos del bucle
      }

      // Agregamos las películas obtenidas a la lista total
      allMovies = allMovies.concat(data.results);
      currentPage++; // Pasamos a la siguiente página
    }

    // Limitamos la cantidad de películas a 50
    allMovies = allMovies.slice(0, 50);

    // Aplicamos el orden solo si se ha especificado
    if (order === "asc") {
      allMovies.sort((a, b) => a.title.localeCompare(b.title));
    } else if (order === "desc") {
      allMovies.sort((a, b) => b.title.localeCompare(a.title));
    }

    return res.status(200).json({
      msg: `Películas obtenidas correctamente (${allMovies.length} registros)`,
      data: allMovies,
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
  const { id } = req.params;
  const params = `movie/${id}/images`;

  try {
    const URL = `${BASE_URL}/${params}?api_key=${API_KEY}`;
    const { data } = await axios.get(URL);

    // Verificamos si hay imágenes
    if (!data || (!data.backdrops && !data.posters)) {
      return res.status(404).json({
        msg: "No se encontraron imágenes para esta película",
        data: {},
      });
    }

    return res.status(200).json({
      msg: "Imágenes obtenidas correctamente",
      backdrops: data.backdrops,
      posters: data.posters,
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

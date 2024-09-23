// Tu API Key, esto deberia ser personal de cada, luego lo cambio al .env para que se commitee y cada uno lo tengo en su compu.
const API_KEY = process.env.API_KEY;
const BASE_URL = 'https://api.themoviedb.org/3'

module.exports = {
    BASE_URL,
    API_KEY,

}

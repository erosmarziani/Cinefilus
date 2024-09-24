## API con express creada con NodeJS

Puntuados:
para obtener lista de 50 puntuados: "http://localhost:3000/puntuados"

para obtener lista de puntuados por id: "http://localhost:3000/puntuados/{id}"

para obtener lista de puntuados por idioma: "http://localhost:3000/puntuados/top-rated/language?language=es-ES"

TvShows:

Para mostrar mas de 50 programas de tv en tendencia http://localhost:3000/api/v1/tv/trending/week

para obtener programa filtrado por ID http://localhost:3000/api/v1/tv/194764

para filtrar por pagina http://localhost:3000/api/v1/tv/trending/week?page=2

Popular:

Para obtener como minimo 50 peliculas proximas a estrenar http://localhost:3000/popular
Para obtener imagenes de peliculas por ID http://localhost:3000/popular/{id} EJ 5
Para filtrar por idioma http://localhost:3000/popular?lang={codigoIdioma} ejemplo : http://localhost:3000/popular?lang=es-ES


Upcoming: 
Para obtener como minimo 50 peliculas proximas a estrenar http://localhost:3000/upcoming
Para obtener pelicula a estrenar por ID http://localhost:3000/upcoming/{id} EJ 917496
Para filtrar por idioma http://localhost:3000/upcoming?lang={codigoIdioma} ejemplo : http://localhost:3000/upcoming?lang=es-ES 

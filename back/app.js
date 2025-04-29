    require('dotenv').config()

    console.log("BASE_URL:", process.env.BASE_URL);
console.log("API_KEY:", process.env.API_KEY);
    const Server = require('./models/server')
    
    const servidor = new Server()

    servidor.listen()

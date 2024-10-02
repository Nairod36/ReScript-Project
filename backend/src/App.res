open Express
open UserRoutes // Assurez-vous d'importer les routes utilisateur
@module("dotenv") external config: unit => unit = "config"
config()

let app = expressCjs()

// Crée un routeur pour gérer certaines routes spécifiques
let router = Router.make()

// Middleware pour logger chaque requête
router->Router.use((req, _res, next) => {
  Js.log(req)
  next()
})

// Middleware pour gérer les erreurs dans le routeur
router->Router.useWithError((err, _req, res, _next) => {
  Js.Console.error(err)
  let _ = res->status(500)->endWithData("An error occurred")
})

// Middleware global pour gérer les erreurs
app->useWithError((err, _req, res, _next) => {
  Js.Console.error(err)
  let _ = res->status(500)->endWithData("An error occurred")
})

// Middleware pour parser le JSON
app->use(jsonMiddleware())

// Ajout du routeur à l'application
app->use("/api/users", UserRoutes.router)

// Démarrage du serveur sur le port 8081
let port = 8081
let _ = app->listenWithCallback(port, _ => {
  Js.Console.log(`Listening on http://localhost:${port->Belt.Int.toString}`)
})

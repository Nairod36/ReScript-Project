open Express
open UserService // Assurez-vous d'importer le service
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
app->useRouterWithPath("/api/users", router)

// Route pour enregistrer un nouvel utilisateur
router->Router.post("/register", (req, res) => {
  let user = req->Express.requestBody
  let username = user["username"]->Js.Json.decodeString |> Js.Option.getExn
  let password = user["password"]->Js.Json.decodeString |> Js.Option.getExn

  registerUser(username, password)
  |> then_(result => {
    switch result {
    | Result.Ok(message) => res->status(201)->json({"message": message})
    | Result.Error(errMsg) => res->status(400)->json({"error": errMsg})
    }
  })
  |> catch(_ => res->status(500)->json({"error": "Internal Server Error"}))
})

// Route pour connecter un utilisateur
router->Router.post("/login", (req, res) => {
  let credentials = req->Express.requestBody
  let username = credentials["username"]->Js.Json.decodeString |> Js.Option.getExn
  let password = credentials["password"]->Js.Json.decodeString |> Js.Option.getExn

  loginUser(username, password)
  |> then_(result => {
    switch result {
    | Result.Ok(message) => res->status(200)->json({"message": message})
    | Result.Error(errMsg) => res->status(400)->json({"error": errMsg})
    }
  })
  |> catch(_ => res->status(500)->json({"error": "Internal Server Error"}))
})

// Démarrage du serveur sur le port 8081
let port = 8081
let _ = app->listenWithCallback(port, _ => {
  Js.Console.log(`Listening on http://localhost:${port->Belt.Int.toString}`)
})

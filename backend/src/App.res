open Express

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
  let _ = res->status(500)->endWithData("An error occured")
})

// Ajout du routeur à l'application
app->useRouterWithPath("/someRoute", router)

// Middleware pour parser le JSON
app->use(jsonMiddleware())

// Route GET
app->get("/", (_req, res) => {
  let _ = res->status(200)->json({"ok": true})
})

// Route qui gère toutes les méthodes HTTP
app->all("/allRoute", (_req, res) => {
  res->status(200)->json({"ok": true})->ignore
})

// Middleware global pour gérer les erreurs
app->useWithError((err, _req, res, _next) => {
  Js.Console.error(err)
  let _ = res->status(500)->endWithData("An error occured")
})

// Démarrage du serveur sur le port 8081
let port = 8081
let _ = app->listenWithCallback(port, _ => {
  Js.Console.log(`Listening on http://localhost:${port->Belt.Int.toString}`)
})

open Express

let app = express()

app->use(jsonMiddleware())


app->get("/", (_req, res) => {
  let _ = res->status(200)->json({"ok": true})
})

app->useWithError((err, _req, res, _next) => {
  Js.Console.error(err)
  let _ = res->status(500)->endWithData("An error occured")
})

let port = 8081
let _ = app->listenWithCallback(port, _ => {
  Js.Console.log(`Listening on http://localhost:${port->Belt.Int.toString}`)
})
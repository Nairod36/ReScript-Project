open Express

let quizRouter = Router.make()

// Route GET pour récupérer une question de quiz
quizRouter->Router.get("/quiz", (_req, res) => {
  let _ = res->status(200)->json({"question": "What is ReScript?"})
})

// Route POST pour vérifier une réponse de quiz
quizRouter->Router.post("/quiz", (req, res) => {
  let body = req->body
  let _ = switch body["answer"]->Js.Nullable.toOption {
  | Some(answer) => res->status(200)->json({"correct": answer == "A compiled language"})
  | None => res->status(400)->json({"error": `Missing answer`})
  }
})

// Exporter une fonction pour ajouter ces routes à l'application
let addRoutes = (app) => {
  app->useRouterWithPath("/api", quizRouter)
}

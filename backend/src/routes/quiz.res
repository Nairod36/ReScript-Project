open Express

let quizRouter = Router.make()

// Fonction pour traiter le texte envoyé depuis la reconnaissance vocale
let processSpeech = (transcript: string): string => {
  switch transcript {
  | "start quiz" => "Quiz started"
  | "stop quiz" => "Quiz stopped"
  | _ => "Command not recognized"
  }
}

// Route POST pour traiter le texte envoyé par l'API Speech-to-Text
quizRouter->Router.post("/process-speech", (req, res) => {
  let body = req->body
  let transcript = Js.Nullable.toOption(body["transcript"])

  // Vérification si transcript est défini
  switch transcript {
  | Some(text) => {
      // Logique de traitement du texte (par exemple : vérifier une réponse ou une commande)
      let result = processSpeech(text)

      // Envoie de la réponse au frontend
      res->status(200)->json({"processedResult": result})->ignore
    }
  | None => res->status(400)->json({"error": "Missing transcript"})->ignore
  }
})

// Route GET pour récupérer une question de quiz
quizRouter->Router.get("/quiz", (_req, res) => {
  let _ = res->status(200)->json({"question": "What is ReScript?"})->ignore
})

// Route POST pour vérifier une réponse de quiz
quizRouter->Router.post("/quiz", (req, res) => {
  let body = req->body
  let _ = switch Js.Nullable.toOption(body["answer"]) {
  | Some(answer) => res->status(200)->json({"correct": answer == "A compiled language"})->ignore
  | None => res->status(400)->json({"error": `Missing answer`})->ignore
  }
})

// Exporter une fonction pour ajouter ces routes à l'application
let addRoutes = (app) => {
  app->useRouterWithPath("/api", quizRouter)
}

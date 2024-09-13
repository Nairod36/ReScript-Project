open Express

let app = express()

// Route POST pour générer des questions de quiz
// app->post("/generate-quiz", (req, res) => {
//   let topic = req.body["topic"]->Js.Nullable.toOption

//   switch topic {
//   | Some(topic) => {
//     generateQuizQuestion(topic)->then_(question => {
//       switch question {
//       | Some(q) => res->status(200)->json({"question": q})
//       | None => res->status(500)->json({"error": "Failed to generate question"})
//       }
//     })->catch(_ => res->status(500)->json({"error": "An error occurred"}))
//   }
//   | None => res->status(400)->json({"error": "Missing quiz topic"})
//   }
// })

app->get("/quiz", (_req, res) => {
  let _ = res->status(200)->json({"question": "What is ReScript?"})
})

app->post("/quiz", (req, res) => {
  let body = req->body
  let _ = switch body["answer"]->Js.Nullable.toOption {
  | Some(answer) => res->status(200)->json({"correct": answer == "A compiled language"})
  | None => res->status(400)->json({"error": `Missing answer`})
  }
})

app->useWithError((err, _req, res, _next) => {
  Js.Console.error(err)
  let _ = res->status(500)->endWithData("An error occured")
})
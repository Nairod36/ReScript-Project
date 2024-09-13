open Express

let app = express()


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
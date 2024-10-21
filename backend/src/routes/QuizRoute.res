open Express

let quizRouter = Router.make()

quizRouter->Router.get("/",(req,res)=>{
  let _ = res->status(200)->json({"quiz": true})
})

quizRouter->Router.get("/question", (req, res)=>{
  let params = req->query
  let topic = params["topic"]
  let getQuestion = async (topic:string) => {
    let question = await OpenaiService.postJson(topic)
    let _ = res->status(200)->json({"question":question})
  }
  let _ = getQuestion(topic)
})

// Exporter une fonction pour ajouter ces routes à l'application
let addRoutes = (app) => {
  app->useRouterWithPath("/api", quizRouter)
}

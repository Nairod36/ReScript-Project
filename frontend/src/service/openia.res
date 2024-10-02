open Js.Promise
open Fetch // Assurez-vous que ce module est installé

let apiUrl = "http://localhost:8081/api/generate-quiz" 

let generateQuizQuestion = (topic: string): Js.Promise.t<Js.Json.t> => {
  let body = {
    "topic": topic,
  }

  Fetch.fetch(
    apiUrl,
    {
      "method": "POST",
      "headers": {
        "Content-Type": "application/json",
      },
      "body": Js.Json.stringify(body),
    }
  )
  |> then_(response => {
    if (response.status === 200) {
      response->Fetch.text()
      |> then_(text => resolve(Js.Json.parse(text)))
    } else {
      resolve(Js.Json.null)
    }
  })
  |> catch(_ => resolve(Js.Json.null))
}

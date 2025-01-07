
let generateQuizQuestion = async (topic: string) => {
  open Fetch
  let apiUrl = "http://localhost:8081/api/question?topic="++topic
  let response = await fetch(
    apiUrl,
    {
      method: #GET
    },
  )

  (json => {
    json
  })(await response->Response.json)
}

let _ = generateQuizQuestion("south park")
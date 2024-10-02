open Js.Promise

let apiUrl = "http://localhost:8081/api/generate-quiz"

let generateQuizQuestion = async (topic: string): Js.Promise.t<Js.Json.t> => {
  let body = {
    "topic": topic,
  }

  let response = await fetch(
    apiUrl,
    {
      method: #POST,
      headers: Headers.fromObject({
        "Content-Type": "application/json",
      }),
      body: body->Js.Json.stringifyAny->Body.string,
    },
  )

  if (response->Response.ok) {
    await response->Response.json()
  } else {
    Promise.resolve(Js.Json.null)
  }
}

// open Js.Promise

// Import du fetch depuis bs-fetch
// @module("bs-fetch") external fetch: (string, {..}) => Js.Promise.t<Response.t> = "default"

// Binding pour accéder à process.env
@module("process") external env: {..} = "env"

// Récupération de la clé API OpenAI
let apiKey = switch Js.Nullable.toOption(env["OPENAI_API_KEY"]) {
| Some(key) => key
| None => "default-api-key"
}

// let generateQuizQuestion = (topic: string): Js.Promise.t<option<string>> => {
//   let body = {
//     "model": "text-davinci-003",
//     "prompt": `Generate a quiz question about ${topic}`,
//     "max_tokens": 100,
//   }

//   fetch(
//     "https://api.openai.com/v1/completions",
//     {
//       "method": "POST",
//       "headers": {
//         "Authorization": "Bearer " ++ apiKey,
//         "Content-Type": "application/json",
//       },
//       "body": Js.Json.stringify(body),
//     }
//   )
//   |> then_(response => {
//     if (response.status === 200) {
//       response->text()->then_(question => resolve(Some(question)))
//     } else {
//       resolve(None)
//     }
//   })
//   |> catch(_ => resolve(None))
// }

// open Js.Promise

// // Charge la clé API OpenAI depuis les variables d'environnement
// let apiKey = Js.Option.getExn(Node.Process.env["OPENAI_API_KEY"])

// // Fonction pour générer une question de quiz en appelant l'API OpenAI
// let generateQuizQuestion = (topic: string): Js.Promise.t(option(string)) => {
//   let body = {
//     "model": "text-davinci-003",
//     "prompt": `Generate a quiz question about ${topic}`,
//     "max_tokens": 100,
//   }

//   Fetch.postWithBody(
//     "https://api.openai.com/v1/completions",
//     ~headers={
//       "Authorization": "Bearer " ++ apiKey,
//       "Content-Type": "application/json",
//     },
//     ~body=Js.Json.stringify(body),
//   )
//   |> then_(response => {
//     switch response.status {
//     | 200 => response->text()->then_(question => resolve(Some(question)))
//     | _ => resolve(None)
//     }
//   })
// }

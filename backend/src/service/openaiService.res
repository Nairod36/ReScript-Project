@module("process") external env: {..} = "env"

// Récupération de la clé API OpenAI
let apiKey = switch Js.Nullable.toOption(env["OPENAI_API_KEY"]) {
| Some(key) => key
| None => "default-api-key"
}

let parseToJson = (input: string) => {
  // Question
  let question = switch input->String.split("A)")->Array.at(0) {
  | None => ""
  | Some(elmt) => elmt
  }
  // Options
  let options = switch input->String.split("Réponse correcte :")->Array.at(0) {
  | None => [{"label": "Unkown", "option": "unknown"}]
  | Some(opt) =>
    switch opt->String.split("?\n\n")->Array.at(1) {
    | None => [{"label": "Unkown", "option": "unknown"}]
    | Some(o) =>
      o
      ->String.split("\n")
      ->Array.mapWithIndex((option, index) =>
        switch index {
        | 0 => {"label": "A", "option": option}
        | 1 => {"label": "B", "option": option}
        | 2 => {"label": "C", "option": option}
        | 3 => {"label": "D", "option": option}
        | _ => {"label": "Unkown", "option": option}
        }
      )
    }
  }
  // Response
  let response = input->String.split("Réponse correcte :")->Array.at(1)

  // Return
  {"question": question, "options": options, "response": response}
}

// POST with JSON payload
let postJson = () => {
  let postBanana = async (theme: string, apiKey: string) => {
    open Fetch
    let prompt =
      "Crée une question à choix multiples sur le thème suivant : " ++
      theme ++ ". Fournis 4 réponses possibles, et précise laquelle est correcte."
    let data = {
      "model": "gpt-3.5-turbo",
      "messages": [{"role": "system", "content": prompt}],
      "max_tokens": 150.0,
      "temperature": 0.7,
      "n": 1.0,
    }

    let response = await fetch(
      "https://api.openai.com/v1/chat/completions",
      {
        method: #POST,
        body: data->Js.Json.stringifyAny->Belt.Option.getExn->Body.string,
        headers: Headers.fromObject({
          "Content-type": "application/json",
          "Authorization": "Bearer " ++ apiKey,
        }),
      },
    )

    (
      json => {
        let res = JSON.Decode.object(json)
        switch res {
        | None => Js.log("Unknown response format")
        | Some(data) =>
          switch Dict.get(data, "choices") {
          | None => Js.log("Choices not found")
          | Some(choicesJson) =>
            switch JSON.Decode.array(choicesJson) {
            | None => Js.log("Array not available")
            | Some(arr) =>
              let questionText = Belt.Array.get(arr, 0)
              switch questionText {
              | None => Js.log("Question failed")
              | Some(choice) =>
                let decodedChoice = JSON.Decode.object(choice)
                switch decodedChoice {
                | None => Js.log("Deserialization failed")
                | Some(obj) =>
                  switch Dict.get(obj, "message") {
                  | None => Js.log("Error")
                  | Some(jsonValue) =>
                    switch JSON.Decode.object(jsonValue) {
                    | None => Js.log("Error2")
                    | Some(message) =>
                      switch Dict.get(message, "content") {
                      | None => Js.log("Error3")
                      | Some(content) =>
                        switch JSON.Decode.string(content) {
                        | None => Js.log("")
                        | Some(r) => Js.log(parseToJson(r))
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    )(await response->Response.json)
  }

  postBanana(
    "Langage fonctionnel rescript",
    apiKey,
  )
}

await postJson()

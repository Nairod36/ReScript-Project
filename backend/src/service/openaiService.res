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
      ->Array.slice(~start=0,~end=4)
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
  let response = switch input->String.split("Réponse correcte :")->Array.at(1) {
    |Some(i)=>i->String.charAt(1)
    |None => "D"
  }

  // Return
  {"question": question, "options": options, "response": response}
}

// POST with JSON payload
let postJson = (topic:string) => {
  let postBanana = async (theme: string, apiKey: string) => {
    open Fetch
    let prompt =
      "Crée une question à choix multiples sur le thème suivant : " ++
      theme ++ ". Fournis 4 réponses possibles, et précise laquelle est correcte.Suit le pattern suivant :\n
{Question}\nA){reponse A}\nB){réponse B}\nC){réponse C}\nD){réponse D}\nRéponse correcte : {label de la bonne réponse}"
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
        | None => {
            Js.log("Unknown response format")
            Js.Json.null
          }
        | Some(data) =>
          switch Dict.get(data, "choices") {
          | None => {
              Js.log("Choices not found")
              Js.Json.null
            }
          | Some(choicesJson) =>
            switch JSON.Decode.array(choicesJson) {
            | None => {
                Js.log("Array not available")
                Js.Json.null
              }
            | Some(arr) =>
              let questionText = Belt.Array.get(arr, 0)
              switch questionText {
              | None => {
                  Js.log("Question failed")
                  Js.Json.null
                }
              | Some(choice) =>
                let decodedChoice = JSON.Decode.object(choice)
                switch decodedChoice {
                | None => {
                    Js.log("Deserialization failed")
                    Js.Json.null
                  }
                | Some(obj) =>
                  switch Dict.get(obj, "message") {
                  | None => {
                      Js.log("Error")
                      Js.Json.null
                    }
                  | Some(jsonValue) =>
                    switch JSON.Decode.object(jsonValue) {
                    | None => {
                        Js.log("Error2")
                        Js.Json.null
                      }
                    | Some(message) =>
                      switch Dict.get(message, "content") {
                      | None => {
                          Js.log("Error3")
                          Js.Json.null
                        }
                      | Some(content) =>
                        switch JSON.Decode.string(content) {
                        | None => {
                            Js.log("")
                            Js.Json.null
                          }
                        | Some(r) => {
                          switch parseToJson(r)->Js.Json.stringifyAny{
                            |Some(parsed)=>{
                              Js.Json.parseExn(parsed)
                            }
                            |None => Js.Json.null
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
        }
      }
    )(await response->Response.json)
  }

  postBanana(
    topic,
    apiKey,
  )
}

// await postJson()

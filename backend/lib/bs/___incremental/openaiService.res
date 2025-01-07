@module("process") external env: {..} = "env"

// Récupération de la clé API OpenAI
let apiKey = switch Js.Nullable.toOption(env["OPENAI_API_KEY"]) {
| Some(key) => key
| None => "default-api-key"
}

let parseToJson = (input: string): Js.Json.t => {
  // Tente de parser la chaîne en un objet JSON
  let parsedJson = Js.Json.parseExn(input)
    // Vérifie que le JSON est un objet
    switch Js.Json.decodeObject(parsedJson) {
    | None =>
      Js.Json.object_(
        Js.Dict.fromArray([
          ("question", Js.Json.string("Erreur de parsing")),
          ("choices", Js.Json.array([])),
          ("correctAnswer", Js.Json.string("")),
        ])
      )
    | Some(jsonObj) =>
      // Extraction sécurisée des propriétés
      let question = Js.Dict.get(jsonObj, "question")
        ->Belt.Option.flatMap(Js.Json.decodeString)
        ->Belt.Option.getWithDefault("Erreur de parsing")

      let choices = Js.Dict.get(jsonObj, "choices")
        ->Belt.Option.flatMap(Js.Json.decodeArray)
      let parsedChoices = switch choices {
      | Some(choiceArray) =>
        choiceArray->Array.map(choice =>
          switch Js.Json.decodeObject(choice) {
          | Some(choiceObj) =>
            Js.Json.object_(
              Js.Dict.fromArray([
                ("label", Js.Dict.get(choiceObj, "label")
                  ->Belt.Option.flatMap(Js.Json.decodeString)
                  ->Belt.Option.map(Js.Json.string)
                  ->Belt.Option.getWithDefault(Js.Json.string("Unknown"))),
                ("text", Js.Dict.get(choiceObj, "text")
                  ->Belt.Option.flatMap(Js.Json.decodeString)
                  ->Belt.Option.map(Js.Json.string)
                  ->Belt.Option.getWithDefault(Js.Json.string("Unknown"))),
              ])
            )
          | None => Js.Json.object_(
              Js.Dict.fromArray([
                ("label", Js.Json.string("Unknown")),
                ("text", Js.Json.string("Unknown")),
              ])
            )
          }
        )
      | None => []
      }

      let correctAnswer = Js.Dict.get(jsonObj, "correctAnswer")
        ->Belt.Option.flatMap(Js.Json.decodeString)
        ->Belt.Option.getWithDefault("Unknown")

      // Retourne le JSON reconstruit
      Js.Json.object_(
        Js.Dict.fromArray([
          ("question", Js.Json.string(question)),
          ("choices", Js.Json.array(parsedChoices)),
          ("correctAnswer", Js.Json.string(correctAnswer)),
        ])
      )
    }
}

// POST with JSON payload
let postJson = (topic:string) => {
  let postBanana = async (theme: string, apiKey: string) => {
    open Fetch
    let prompt =
      "Crée une question à choix multiples sur le thème suivant : " ++ theme
    let data = {
      "model": "gpt-4o-mini",
      "messages": [{"role": "system", "content": prompt}],
      "max_tokens": 150.0,
      "temperature": 0.7,
      "n": 1.0,
      "response_format": {
    "type": "json_schema",
    "json_schema": {
      "name": "quiz_question",
      "strict": true,
      "schema": {
        "type": "object",
        "properties": {
          "question": {
            "type": "string"
          },
          "choices": {
            "type": "array",
            "items": {
              "type": "object",
              "properties": {
                "label": {
                  "type": "string"
                },
                "text": {
                  "type": "string"
                }
              },
              "required": [
                "label",
                "text"
              ],
              "additionalProperties": false
            }
          },
          "correctAnswer": {
            "type": "string"
          }
        },
        "required": [
          "question",
          "choices",
          "correctAnswer"
        ],
        "additionalProperties": false
      }
    }
  }
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
                            Js.log("Parsing error")
                            Js.Json.null
                          }
                        | Some(r) => {
                          parseToJson(r)
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

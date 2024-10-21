type questionOption = {
    label:string,
    option:string
}

type questionType = {
    question:string,
    options:array<questionOption>,
    response:string
}

let decodeOption = json => {
  switch json |> Js.Json.decodeObject {
  | None => None
  | Some(obj) =>
    let label = obj->Js.Dict.get("label")->Belt.Option.flatMap(Js.Json.decodeString)
    let option = obj->Js.Dict.get("option")->Belt.Option.flatMap(Js.Json.decodeString)

    switch (label, option) {
    | (Some(label), Some(option)) =>
      Some({label, option})
    | _ => None
    }
  }
}

let decodeQuestionModel = json => {
  switch json |> Js.Json.decodeObject {
  | None => None
  | Some(obj) =>
    let apiresponse = obj->Js.Dict.get("question")->Belt.Option.flatMap(Js.Json.decodeObject)
    switch apiresponse {
        |Some(r)=>{
            let q = r->Js.Dict.get("question")->Belt.Option.flatMap(Js.Json.decodeString)
            let o = r->Js.Dict.get("options")->Belt.Option.flatMap(Js.Json.decodeArray)
                ->Belt.Option.map(arr=>arr->Belt.Array.keepMap(decodeOption))
            let r = r->Js.Dict.get("response")->Belt.Option.flatMap(Js.Json.decodeString)
            switch (q, o, r) {
                |(Some(q), Some(o), Some(r)) => Some({question:q, options:o ,response:r})
                | _ => None
            }
        }
        | _ => None
    }
  }
}
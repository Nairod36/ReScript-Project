@val external window: {..} = "window"

// Binding pour accéder à l'API Web Speech
@module("window") external speechRecognition: Js.Nullable.t<{..}> = "webkitSpeechRecognition"

// Bindings pour les propriétés et méthodes de l'objet SpeechRecognition
@set external setContinuous: ({..}, bool) => unit = "continuous"
@set external setInterimResults: ({..}, bool) => unit = "interimResults"
@set external setLang: ({..}, string) => unit = "lang"
@send external startRecognition: {..} => unit = "start"
@send external stopRecognition: {..} => unit = "stop"

// Bindings pour les événements `onresult` et `onerror`
@set external setOnResult: ({..}, {..} => unit) => unit = "onresult"
@set external setOnError: ({..}, {..} => unit) => unit = "onerror"

// Binding pour accéder aux résultats de l'événement `onresult`
@val external getResults: {..} => Js.Array.array_like<{..}> = "results"
@val external getTranscript: {..} => string = "transcript"

// Composant React en ReScript
@react.component
let make = () => {
  let (transcript, setTranscript) = React.useState(() => "")
  let (listening, setListening) = React.useState(() => false)

  // Obtenir l'objet `SpeechRecognition`
  let recognition = Js.Nullable.toOption(speechRecognition) |> Js.Option.getExn

  // Utiliser les bindings externes pour modifier les propriétés
  setContinuous(recognition, true)
  setInterimResults(recognition, true)
  setLang(recognition, "en-US")

  // Utiliser l'effet pour enregistrer les événements `onresult` et `onerror`
  React.useEffect1(() => {
    setOnResult(recognition, event => {
      let results = getResults(event) // Obtenir les résultats

      // Convertir les résultats en tableau et obtenir les transcriptions
      let currentTranscript =
        Js.Array.from(results) // Convertir les résultats en tableau
        ->Belt.Array.map(result => getTranscript(result)) // Obtenir les transcriptions
        ->Js.String.concat("") // Joindre toutes les transcriptions en une seule chaîne

      // Mettre à jour l'état avec la chaîne concaténée
      setTranscript(currentTranscript) // Passer la chaîne à setTranscript
    })

    setOnError(recognition, event => {
      Js.Console.error("Speech recognition error:", event)
    })

    None
  }, [recognition])

  // Fonctions pour démarrer et arrêter la reconnaissance vocale
  let startListening = () => {
    setListening(_ => true)
    startRecognition(recognition)
  }

  let stopListening = () => {
    setListening(_ => false)
    stopRecognition(recognition)
  }

  // Interface utilisateur
  <div>
    <h1> {"Speech to Text"->React.string} </h1>
    <p> {transcript->React.string} </p>
    <button onClick={_ => listening ? stopListening() : startListening()}>
      {listening ? "Stop Listening"->React.string : "Start Listening"->React.string}
    </button>
  </div>
}

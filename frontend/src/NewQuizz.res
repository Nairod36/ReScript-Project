@react.component
let make = (~generate:(option<string>)=>promise<unit>, ~setTopic:(string=>string)=>unit, ~iter:int, ~setIter:(int=>int)=>unit) => {

  // Liste des 8 thèmes
  let themes = ["Sport", "Histoire", "Géographie", "Cinéma", "Musique", "Art", "Littérature", "Technologie", "South Park", "Shameless", "Futurama", "Brokeback Mountain"]

  // Fonction pour sélectionner 4 thèmes aléatoires parmi les 8
  let getRandomThemes = (themes: array<string>, count: int) => {
    themes
    ->Belt.Array.shuffle
    ->Belt.Array.slice(~offset=0, ~len=count)
  }

  let randomThemes = React.useMemo(() => getRandomThemes(themes, 4), [themes])

  let handleThemeClick = (newTopic: string) => {
    let difer = async () => {
      let _ = await generate(Some(newTopic))
      setTopic(_=>newTopic)   
    }
    let _ = difer()
  }

  <div className="create-quiz-container custom-bg">

    <div className="questions-group">
      <div className="label">{React.string("Nombre de questions")}</div>
      // <input onChange={event => {let value = ReactEvent.Form.target(event)["value"]; setIter(_ =>value->Belt.Int.fromString->Belt.Option.getWithDefault(1))}} type_="range" min={"1"} max="20" value={Js.Int.toString(iter)} className="range" step=5.0 />
      // <div className="flex w-full justify-between px-2 text-xs">
      //   <span>{React.string("1")}</span>
      //   <span>{React.string("5")}</span>
      //   <span>{React.string("10")}</span>
      //   <span>{React.string("15")}</span>
      //   <span>{React.string("20")}</span>
      // </div>
      <div className="radio-group">
        <label>
          <input
            type_="radio"
            name="questions"
            value="5"
            checked={iter === 5}
            onChange={_ => setIter(_ => 5)}
          />
          {React.string("5")}
        </label>
        <label>
          <input
            type_="radio"
            name="questions"
            value="10"
            checked={iter === 10}
            onChange={_ => setIter(_ => 10)}
          />
          {React.string("10")}
        </label>
        <label>
          <input
            type_="radio"
            name="questions"
            value="20"
            checked={iter === 20}
            onChange={_ => setIter(_ => 20)}
          />
          {React.string("20")}
        </label>
      </div>
    </div>

    <div className="themes">
      <div className="label">{React.string("Choisissez un thème")}</div>
      <div className="answers">
        {React.array(
          randomThemes->Array.map(theme =>
            <button
              className="answer-button"
              onClick={_ => handleThemeClick(theme)}
            >
              {React.string(theme)}
            </button>
          )
        )}
      </div>
    </div>
  </div>
}

@react.component
let make = () => {
  let (selectedQuestions, setSelectedQuestions) = React.useState(() => 10)

  // Liste des 8 thèmes
  let themes = ["Sport", "Histoire", "Géographie", "Cinéma", "Musique", "Art", "Littérature", "Technologie"]

  // Fonction pour sélectionner 4 thèmes aléatoires parmi les 8
  let getRandomThemes = (themes: array<string>, count: int) => {
    themes
    ->Belt.Array.shuffle
    ->Belt.Array.slice(~offset=0, ~len=count) // Supprime le `()` ici
  }

  let randomThemes = React.useMemo(() => getRandomThemes(themes, 4), [themes])

  let handleThemeClick = (theme: string) => {
    Js.log("Thème sélectionné: " ++ theme)
  }

  <div className="create-quiz-container custom-bg">
    <div className="questions-group">
      <div className="label">{React.string("Nombre de questions")}</div>
      <div className="radio-group">
        <label>
          <input
            type_="radio"
            name="questions"
            value="5"
            checked={selectedQuestions === 5}
            onChange={_ => setSelectedQuestions(_ => 5)}
          />
          {React.string("5")}
        </label>
        <label>
          <input
            type_="radio"
            name="questions"
            value="10"
            checked={selectedQuestions === 10}
            onChange={_ => setSelectedQuestions(_ => 10)}
          />
          {React.string("10")}
        </label>
        <label>
          <input
            type_="radio"
            name="questions"
            value="20"
            checked={selectedQuestions === 20}
            onChange={_ => setSelectedQuestions(_ => 20)}
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

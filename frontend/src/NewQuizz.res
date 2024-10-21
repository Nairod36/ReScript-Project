@react.component
let make = (~question:Js.Json.t,~quizHook:(Js.Json.t => Js.Json.t)=>unit) => {

  // Liste des 8 thèmes
  let themes = ["Sport", "Histoire", "Géographie", "Cinéma", "Musique", "Art", "Littérature", "Technologie", "South Park", "Shameless", "Futurama"]

  // Fonction pour sélectionner 4 thèmes aléatoires parmi les 8
  let getRandomThemes = (themes: array<string>, count: int) => {
    themes
    ->Belt.Array.shuffle
    ->Belt.Array.slice(~offset=0, ~len=count)
  }

  let randomThemes = React.useMemo(() => getRandomThemes(themes, 4), [themes])

  let handleThemeClick = (theme: string) => {
    let generate = async (theme:string) => {
      (newQuestion => quizHook(question=>newQuestion))(await Openai.generateQuizQuestion(theme))
    }
    let _ = generate(theme)
    ()
  }

  <div className="create-quiz-container custom-bg">
    // <div className="questions-group">
    //   <div className="label">{React.string("Nombre de questions")}</div>
    //   <div className="radio-group">
    //     <label>
    //       <input
    //         type_="radio"
    //         name="questions"
    //         value="5"
    //         checked={selectedQuestions === 5}
    //         onChange={_ => setSelectedQuestions(_ => 5)}
    //       />
    //       {React.string("5")}
    //     </label>
    //     <label>
    //       <input
    //         type_="radio"
    //         name="questions"
    //         value="10"
    //         checked={selectedQuestions === 10}
    //         onChange={_ => setSelectedQuestions(_ => 10)}
    //       />
    //       {React.string("10")}
    //     </label>
    //     <label>
    //       <input
    //         type_="radio"
    //         name="questions"
    //         value="20"
    //         checked={selectedQuestions === 20}
    //         onChange={_ => setSelectedQuestions(_ => 20)}
    //       />
    //       {React.string("20")}
    //     </label>
    //   </div>
    // </div>

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

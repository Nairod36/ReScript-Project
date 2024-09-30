@react.component
let make = () => {
  let (score, setScore) = React.useState(() => 0)

  let question = "Quelle est la capitale de la France?"
  let answers = ["Paris", "Londres", "Berlin", "Madrid"]

  let handleAnswerClick = (answer: string) => {
    Js.log(answer ++ " clicked!")
    setScore(prevScore => prevScore + 1)
  }

  <div className="flex flex-col justify-between min-h-screen custom-bg">
    <div className="flex flex-col items-center justify-start">
      <h1 className="question">{React.string(question)}</h1>
      <div className="answers">
        {React.array(
          answers->Array.map(answer =>
            <button
              className="answer-button"
              onClick={_ => handleAnswerClick(answer)}
            >
              {React.string(answer)}
            </button>
          )
        )}
      </div>
    </div>

    <div className="score mb-4">
      {React.string("Score: " ++ string_of_int(score))}
    </div>
  </div>
}

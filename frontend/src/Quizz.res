@react.component
let make = (~quizQuestion:Js.Json.t) => {
  let (score, setScore) = React.useState(() => 0)
  let questionModel = QuestionModel.decodeQuestionModel(quizQuestion)
  let (question, answers, response) = switch questionModel {
    | Some(q) => (q.question, q.options, q.response)
    | _ => ("test", [{label: "t", option: "test"}], "")
  }

  let handleAnswerClick = (answer: string) => {
    Js.log(answer ++ " clicked!")
    if(answer === response){
      setScore(prevScore => prevScore + 1)
    }
  }

  <div className="flex flex-col justify-between min-h-screen custom-bg">
    <div className="flex flex-col items-center justify-start">
      <h1 className="question">{React.string(question)}</h1>
      <div className="answers">
        {React.array(
          answers->Array.map(answer =>
            <button
              label={answer.label}
              className="answer-button"
              onClick={_ => handleAnswerClick(answer.label)}
            >
              {React.string(answer.option)}
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

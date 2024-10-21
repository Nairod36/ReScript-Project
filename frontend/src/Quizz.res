@react.component
let make = (~quizQuestion:Js.Json.t, ~score:int, ~setScore:(int=>int)=>unit, ~reset:()=>unit) => {
  let (clicked, setClicked) = React.useState(() => false)
  let (selected, setSelected) = React.useState(()=>"")
  let questionModel = QuestionModel.decodeQuestionModel(quizQuestion)
  let (question, answers, response) = switch questionModel {
    | Some(q) => (q.question, q.options, q.response)
    | _ => ("test", [{label: "t", option: "test"}], "")
  }

  let handleAnswerClick = (answer: string) => {
    Js.log(answer ++ " clicked!")
    setClicked(clicked => true)
    setSelected(selected => answer)
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
              disabled = {clicked}
              label={answer.label}
              className={clicked ? answer.label === response ? "correct-answer": answer.label === selected ? "wrong-answer" : "neutral-answer" : "answer-button"}
              // className="answer-button"
              onClick={_ => handleAnswerClick(answer.label)}
            >
              {React.string(answer.option)}
            </button>
          )
        )}
      </div>
    </div>

    <div className="score mb-4 flex flex-col align-middle">
      {React.string("Score: " ++ string_of_int(score))}
      {clicked ? <button className={"next-button"} onClick={_ => reset()}>{React.string("NEXT")}</button> : <></>}
    </div>
  </div>
}

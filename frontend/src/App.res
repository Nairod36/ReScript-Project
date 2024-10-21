// @module("./assets/logo.svg") external logo: string = "default"
// %%raw(`import './App.css'`)


@react.component
let make = () => {
  let (quizQuestion, setQuizQuestion) = React.useState(() => Js.Json.null)
  let (score, setScore) = React.useState(()=>0)
  let reset = () => {
    setQuizQuestion(json => Js.Json.Null)
  }
  let (iter, setIter) = React.useState(()=>0)
  Js.log(quizQuestion)
  switch quizQuestion {
    |Js.Json.Null => {
      <NewQuizz.make question=quizQuestion quizHook=setQuizQuestion/>
    }
    | _ => {
    <Quizz.make quizQuestion score setScore reset/>
    }
  }
}
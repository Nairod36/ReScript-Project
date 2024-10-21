// @module("./assets/logo.svg") external logo: string = "default"
// %%raw(`import './App.css'`)


@react.component
let make = () => {
  let (quizQuestion, setQuizQuestion) = React.useState(() => Js.Json.null)
  let (score, setScore) = React.useState(()=>0)
  let (topic, setTopic) = React.useState(()=>"")
  let reset = () => {
    setQuizQuestion(json => Js.Json.Null)
  }
  let generate = async (newTopic:option<string>) => {
    let focus = switch newTopic {
      |Some(t) => t
      |None => topic
    }
    (newQuestion => setQuizQuestion(_=>newQuestion))(await Openai.generateQuizQuestion(focus))
  }
  let (iter, setIter) = React.useState(()=>5)
  switch (iter, quizQuestion) {
    |(_,Js.Json.Null) => {
      <NewQuizz.make generate setTopic iter setIter/>
    }
    |(0,_) => {
      <NewQuizz.make generate setTopic iter setIter/>
    }
    | _ => {
    <Quizz.make generate iter setIter quizQuestion score setScore reset/>
    }
  }
}
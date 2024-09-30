@react.component
let make = () => {
  let handleButtonClick = (path => {
    Js.log("Button clicked!")
    RescriptReactRouter.push(path)
  })

  <header className="header">
    <button
      className="header-button"
      onClick={_ => handleButtonClick("Home")}
    >
      {React.string("Home")}
    </button>
    <button
      className="header-button"
      onClick={_ => handleButtonClick("Quizz")}
    >
      {React.string("Quizz")}
    </button>
    <button
      className="header-button"
      onClick={_ => handleButtonClick("NewQuizz")}
    >
      {React.string("NewQuizz")}
    </button>
    <button
      className="header-button"
      onClick={_ => handleButtonClick("Account")}
    >
      {React.string("Account")}
    </button>
  </header>
}
@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  // Retour explicite du JSX avec un fragment ou une div
  <div>
    {switch url.path {
      // | list{""} => <Home />
      | list{"Home"} => <Home />
      // | list{"Account"} => <Account />
      // | list{"Quizz"} => <Quizz />
      // | list{"NewQuizz"} => <NewQuizz />
      | _ => <NotFound />
    }}
  </div>
}

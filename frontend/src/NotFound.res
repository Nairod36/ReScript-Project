@react.component
let make = () => {
  let handleGoBack = () => {
    Js.log("Redirecting to home...")
  }

  <div className="not-found-container custom-bg">
    <h1 className="not-found-title">{React.string("404")}</h1>
    <p className="not-found-text">
      {React.string("Oups! La page que vous cherchez n'existe pas.")}
    </p>
    <button
      className="go-back-button"
      onClick={_ => handleGoBack()}
    >
      {React.string("Retour à l'accueil")}
    </button>
  </div>
}

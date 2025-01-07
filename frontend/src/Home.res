@react.component
let make = () => {
  // Handler pour le clic sur l'image-bouton
  let handleImageClick = (path => {
    RescriptReactRouter.push(path)
  })

  <div className="centered-image-button custom-bg">
    <img
      className="image-button"
      src="../public/qvgdm.png"
      alt="Clickable button"
      onClick={_ => handleImageClick("Account")}
      onError={_ => Js.log("Failed to load image")}
    />
  </div>
}

@react.component
let make = () => {
  let (isLogin, setIsLogin) = React.useState(() => true)
  let (message, setMessage) = React.useState(() => "")

  let handleLogin = (event) => {
    event->React.Event.preventDefault()
    let username = event.target["username"]->React.Dom.inputValue
    let password = event.target["password"]->React.Dom.inputValue

    UserService.login(username, password)
    |> then_(result => {
      switch result {
      | Some(data) => setMessage("Login successful!")
      | None => setMessage("Login failed!")
      }
    })
  }

  let handleRegister = (event) => {
    event->React.Event.preventDefault()
    let username = event.target["username"]->React.Dom.inputValue
    let email = event.target["email"]->React.Dom.inputValue
    let password = event.target["password"]->React.Dom.inputValue

    let newUser = User.make(0, username, email, password) // Utiliser votre modèle User
    UserService.register(newUser)
    |> then_(result => {
      switch result {
      | Some(data) => setMessage("Registration successful!")
      | None => setMessage("Registration failed!")
      }
    })
  }

  let loginForm = () => {
    <form onSubmit={handleLogin} className="space-y-4">
      <div className="flex flex-col">
        <label htmlFor="username" className="mb-1 text-sm font-semibold text-white">{"Nom d'utilisateur"->React.string}</label>
        <input id="username" name="username" type_="text" required={true} className="p-2 border border-gray-300 rounded-md" />
      </div>
      <div className="flex flex-col">
        <label htmlFor="password" className="mb-1 text-sm font-semibold text-white">{"Mot de passe"->React.string}</label>
        <input id="password" name="password" type_="password" required={true} className="p-2 border border-gray-300 rounded-md" />
      </div>
      <button type_="submit" className="w-full button-custom">{"Se connecter"->React.string}</button>
    </form>
  }

  let registerForm = () => {
    <form onSubmit={handleRegister} className="space-y-4">
      <div className="flex flex-col">
        <label htmlFor="username" className="mb-1 text-sm font-semibold text-white">{"Nom d'utilisateur"->React.string}</label>
        <input id="username" name="username" type_="text" required={true} className="p-2 border border-gray-300 rounded-md" />
      </div>
      <div className="flex flex-col">
        <label htmlFor="email" className="mb-1 text-sm font-semibold text-white">{"Email"->React.string}</label>
        <input id="email" name="email" type_="email" required={true} className="p-2 border border-gray-300 rounded-md" />
      </div>
      <div className="flex flex-col">
        <label htmlFor="password" className="mb-1 text-sm font-semibold text-white">{"Mot de passe"->React.string}</label>
        <input id="password" name="password" type_="password" required={true} className="p-2 border border-gray-300 rounded-md" />
      </div>
      <button type_="submit" className="w-full button-custom">{"S'inscrire"->React.string}</button>
    </form>
  }

  <div className="min-h-screen custom-bg flex items-center justify-center">
    <div className="max-w-md w-full p-6 secondary-color rounded-lg shadow-md">
      <h1 className="text-2xl font-bold text-center text-white mb-6">
        {isLogin ? "Se connecter" : "S'inscrire"->React.string}
      </h1>
      {isLogin ? loginForm() : registerForm()}
      <button onClick={_ => setIsLogin(prev => !prev)} className="w-full button-custom mt-4">
        {isLogin ? "Pas de compte ? S'inscrire" : "Déjà inscrit ? Se connecter"->React.string}
      </button>
      <p className="text-red-500 text-center mt-4">{message}</p>
    </div>
  </div>
}

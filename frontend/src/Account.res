@react.component
let make = () => {
  // Hook pour suivre l'état (inscription ou connexion)
  let (isLogin, setIsLogin) = React.useState(() => true)

  // Composant de formulaire de connexion
  let loginForm = () => {
    <form className="space-y-4">
      <div className="flex flex-col">
        <label htmlFor="email" className="mb-1 text-sm font-semibold text-white">{React.string("Email")}</label>
        <input
          id="email"
          name="email"
          type_="email"
          required={true}
          className="p-2 border border-gray-300 rounded-md"
        />
      </div>
      <div className="flex flex-col">
        <label htmlFor="password" className="mb-1 text-sm font-semibold text-white">{React.string("Mot de passe")}</label>
        <input
          id="password"
          name="password"
          type_="password"
          required={true}
          className="p-2 border border-gray-300 rounded-md"
        />
      </div>
      <button
        type_="submit"
        className="w-full button-custom"
      >
        {React.string("Se connecter")}
      </button>
    </form>
  }

  // Composant de formulaire d'inscription
  let registerForm = () => {
    <form className="space-y-4">
      <div className="flex flex-col">
        <label htmlFor="username" className="mb-1 text-sm font-semibold text-white">{React.string("Nom d'utilisateur")}</label>
        <input
          id="username"
          name="username"
          type_="text"
          required={true}
          className="p-2 border border-gray-300 rounded-md"
        />
      </div>
      <div className="flex flex-col">
        <label htmlFor="email" className="mb-1 text-sm font-semibold text-white">{React.string("Email")}</label>
        <input
          id="email"
          name="email"
          type_="email"
          required={true}
          className="p-2 border border-gray-300 rounded-md"
        />
      </div>
      <div className="flex flex-col">
        <label htmlFor="password" className="mb-1 text-sm font-semibold text-white">{React.string("Mot de passe")}</label>
        <input
          id="password"
          name="password"
          type_="password"
          required={true}
          className="p-2 border border-gray-300 rounded-md"
        />
      </div>
      <button
        type_="submit"
        className="w-full button-custom"
      >
        {React.string("S'inscrire")}
      </button>
    </form>
  }

  // Composant principal avec bascule entre connexion et inscription
  <div className="min-h-screen custom-bg flex items-center justify-center">
    <div className="max-w-md w-full p-6 secondary-color rounded-lg shadow-md">
      <h1 className="text-2xl font-bold text-center text-white mb-6">
        {React.string(isLogin ? "Se connecter" : "S'inscrire")}
      </h1>
      {isLogin ? loginForm() : registerForm()}
      <button
        onClick={_ => setIsLogin(prev => !prev)}
        className="w-full button-custom mt-4"
      >
        {React.string(isLogin ? "Pas de compte ? S'inscrire" : "Déjà inscrit ? Se connecter")}
      </button>
    </div>
  </div>
}

open Js.Promise
open Belt
open UserModel

let users: array<UserModel.user> = []

// Fonction pour enregistrer un nouvel utilisateur
let registerUser = async (username: string, email: string, password: string): Js.Promise.t<Result.t<string, string>> => {
  // Vérifier si l'utilisateur existe déjà
  let existingUser = Belt.Array.getBy(users , (user) => user.username === username)
  switch existingUser {
  | Some(_) => Promise.resolve(Result.Error("User already exists"))
  | None =>
    // Créer un nouvel utilisateur
    let newUser = UserModel.make(Array.length(users), username, email, password)
    let test = Belt.Array.concat(users,[newUser])
    Promise.resolve(Result.Ok("User registered successfully"))
  }
}

// Fonction pour connecter un utilisateur
let loginUser = (username: string, password: string): Js.Promise.t<Result.t<string, string>> => {
  // Vérifier si l'utilisateur existe et que le mot de passe est correct
  let user = Array.getBy(users, user => user.username === username && user.password === password)
  switch user {
  | Some(_) => Promise.resolve(Result.Ok("User logged in successfully"))
  | None => Promise.resolve(Result.Error("Invalid username or password"))
  }
}

// open Express
// open UserService // Assurez-vous que ce module est importé
// open Belt // Importation de Belt pour les fonctions d'array

// let router = Router.make()

// // Route pour enregistrer un nouvel utilisateur
// router->Router.post("/register", (req, res) => {
//   let user = req->body
//   let username = user["username"]->Js.Json.decodeString |> Js.Option.getExn
//   let email = user["email"]->Js.Json.decodeString |> Js.Option.getExn
//   let password = user["password"]->Js.Json.decodeString |> Js.Option.getExn

//   UserService.registerUser(username, email, password)
//   |> Js.Promise.then_(result => {
//     switch result {
//     | Result.Ok(message) => {
//       res->status(201)->json({"message": message})
//       Js.Promise.resolve()
//       }
//     | Result.Error(errMsg) => {
//       res->status(400)->json({"error": errMsg})
//       Js.Promise.resolve()
//       }
//     }
//   })
//   |> Js.Promise.catch(_ => {
//     res->status(500)->json({"error": "Internal Server Error"})
//     Js.Promise.resolve()
//     ()
//     })
// })

// // Route pour connecter un utilisateur
// router->Router.post("/login", (req, res) => {
//   let credentials = req->Express.requestBody
//   let username = credentials["username"]->Js.Json.decodeString |> Js.Option.getExn
//   let password = credentials["password"]->Js.Json.decodeString |> Js.Option.getExn

//   UserService.loginUser(username, password)
//   |> then_(result => {
//     switch result {
//     | Result.Ok(message) => res->status(200)->json({"message": message})
//     | Result.Error(errMsg) => res->status(400)->json({"error": errMsg})
//     }
//   })
//   |> catch(_ => res->status(500)->json({"error": "Internal Server Error"}))
// })


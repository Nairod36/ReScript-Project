// open Js.Promise
// open User

// let apiUrl = "http://localhost:8081/api/users"

// let register = async (user: user): Js.Promise.t<Js.Json.t> => {
//   let body = {
//     "username": user.username,
//     "email": user.email,
//     "password": user.password,
//   } 
//   open Fetch

//   let response = await fetch(
//     apiUrl ++ "/register",
//     {
//       method: #POST,
//       headers: Headers.fromObject({
//         "Content-Type": "application/json",
//       }),
//       body: body->Js.Json.stringifyAny->Body.string,
//     },
//   )

//   if (response->Response.status === 201) {
//     await response->Response.json()
//   } else {
//     Promise.resolve(Js.Json.null)
//   }
// }

// let login = async (username: string, password: string): Js.Promise.t<Js.Json.t> => {
//   let body = {
//     "username": username,
//     "password": password,
//   }
//   open Fetch

//   let response = await fetch(
//     apiUrl ++ "/login",
//     {
//       method: #POST,
//       headers: Headers.fromObject({
//         "Content-Type": "application/json",
//       }),
//       body: body->Js.Json.stringifyAny->Body.string,
//     },
//   )

//   if (response->Response.ok) {
//     await response->Response.json()
//   } else {
//     Promise.resolve(Js.Json.null)
//   }
// }

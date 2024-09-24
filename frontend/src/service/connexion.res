open Js.Promise
open Fetch // Assurez-vous que ce module est installé
open User

let apiUrl = "http://localhost:8081/api/users" 
let register = (user: user): Js.Promise.t<Js.Json.t> => {
  let body = {
    "username": user.username,
    "email": user.email,
    "password": user.password,
  }

  Fetch.fetch(
    apiUrl ++ "/register",
    {
      "method": "POST",
      "headers": {
        "Content-Type": "application/json",
      },
      "body": Js.Json.stringify(body),
    }
  )
  |> then_(response => {
    if (response.status === 201) {
      response->Fetch.text()
      |> then_(text => resolve(Js.Json.parse(text)))
    } else {
      resolve(Js.Json.null)
    }
  })
  |> catch(_ => resolve(Js.Json.null))
}

let login = (username: string, password: string): Js.Promise.t<Js.Json.t> => {
  let body = {
    "username": username,
    "password": password,
  }

  Fetch.fetch(
    apiUrl ++ "/login",
    {
      "method": "POST",
      "headers": {
        "Content-Type": "application/json",
      },
      "body": Js.Json.stringify(body),
    }
  )
  |> then_(response => {
    if (response.status === 200) {
      response->Fetch.text()
      |> then_(text => resolve(Js.Json.parse(text)))
    } else {
      resolve(Js.Json.null)
    }
  })
  |> catch(_ => resolve(Js.Json.null))
}

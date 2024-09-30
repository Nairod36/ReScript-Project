type user = {
  id: int,
  username: string,
  email: string,
  password: string,
}

let make = (id: int, username: string, email: string, password: string): user => {
  {id, username, email, password}
}


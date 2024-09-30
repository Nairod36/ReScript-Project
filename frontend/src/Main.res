%%raw("import './index.css'")
@react.component
let make = () => {
  switch ReactDOM.querySelector("#root") {
  | Some(domElement) =>
    ReactDOM.Client.createRoot(domElement)->ReactDOM.Client.Root.render(
      <React.StrictMode>
        <App />
      </React.StrictMode>,
    )
  | None => ()
  }
  <div />
}

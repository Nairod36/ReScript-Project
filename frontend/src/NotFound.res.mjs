// Generated by ReScript, PLEASE EDIT WITH CARE

import * as JsxRuntime from "react/jsx-runtime";

function NotFound(props) {
  return JsxRuntime.jsxs("div", {
              children: [
                JsxRuntime.jsx("h1", {
                      children: "404",
                      className: "not-found-title"
                    }),
                JsxRuntime.jsx("p", {
                      children: "Oups! La page que vous cherchez n'existe pas.",
                      className: "not-found-text"
                    }),
                JsxRuntime.jsx("button", {
                      children: "Retour à l'accueil",
                      className: "go-back-button",
                      onClick: (function (param) {
                          console.log("Redirecting to home...");
                        })
                    })
              ],
              className: "not-found-container custom-bg"
            });
}

var make = NotFound;

export {
  make ,
}
/* react/jsx-runtime Not a pure module */
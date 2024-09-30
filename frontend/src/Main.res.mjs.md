import * as React from "react";
import './index.css';
import * as ReactDOM from "react-dom/client"; // <-- Correction ici
import * as JsxRuntime from "react/jsx-runtime";
import * as App from "./App.res.mjs"; // <-- Assurez-vous que cela correspond à votre structure de projet

console.log("Main.res.mjs is loaded");

document.addEventListener("DOMContentLoaded", () => {
  console.log("DOM fully loaded and parsed");

  function Main(props) {
    console.log("Main component is rendering...");

    var domElement = document.querySelector("#root");
    if (domElement == null) {
      console.log("Could not find #root element.");
      return;
    }

    console.log("#root element found, rendering the app...");

    try {
      ReactDOM.createRoot(domElement).render(JsxRuntime.jsx(React.StrictMode, {
        children: JsxRuntime.jsx(App.make, {})
      }));
      console.log("App is rendered!");
    } catch (error) {
      console.error("Error during rendering:", error);
    }
  }

  Main();
});

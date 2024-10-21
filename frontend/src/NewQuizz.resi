@react.component
let make: (~question:Js.Json.t,~quizHook:(Js.Json.t => Js.Json.t)=>unit) => React.element
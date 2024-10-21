@react.component
let make: (~quizQuestion:Js.Json.t, ~score:int, ~setScore:(int=>int)=>unit, ~reset:()=>unit) => React.element
@react.component
let make: (~generate:(option<string>)=>promise<unit>, ~setTopic:(string=>string)=>unit, ~iter:int, ~setIter:(int=>int)=>unit) => React.element
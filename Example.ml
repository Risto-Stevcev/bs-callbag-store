open CallbagStore
open CallbagBasics

type state = { foobar: int }
type action = SetFoobar of int | Default

let { dispatch; store; getState } = {foobar=1} |> make @@ fun state action ->
  match action with
  | SetFoobar foobar -> {foobar = state.foobar + foobar}
  | Default -> state
;;

store
|> scan (fun prev curr -> Js.Array.concat [|curr|] prev) [||]
|> skip 2
|> for_each Js.log
;;

dispatch (SetFoobar 3);;
dispatch (SetFoobar 7);;

Js.log (getState ())

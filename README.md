# bs-callbag-store

A callbag implementation of a redux-like store


## Install

```sh
npm i --save @ristostevcev/bs-callbag-store
```

## Usage

```ocaml
type state = { foobar: int }
type action = SetFoobar of int | Default

let { dispatch; store; get_state } = {foobar=1} |> make @@ fun state action ->
  match action with
  | SetFoobar foobar -> {foobar = state.foobar + foobar}
  | Default -> state

let _ =
  store
  |> scan (fun prev curr -> Js.Array.concat [|curr|] prev) [||]
  |> skip 2
  |> for_each Js.log;

  dispatch (SetFoobar 3);
  dispatch (SetFoobar 7);
  Js.log (get_state ())
```

type ('state, 'action) store =
  { getState: unit -> 'state
  ; dispatch: 'action -> unit
  ; store: 'state Callbag.t
  } [@@bs.deriving jsConverter]

module Internal = struct
  type ('state, 'action) store =
    < getState: unit -> 'state
    ; dispatch: 'action -> unit
    ; store: 'state Callbag.t
    > Js.t

  external make: ('state -> 'action -> 'state [@bs.uncurry]) -> 'state -> ('state, 'action) store = "callbag-store"
  [@@bs.module]
end

let make reducer initial_state = Internal.make reducer initial_state |> storeFromJs

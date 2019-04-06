type ('state, 'action) store =
  { get_state: unit -> 'state
  ; dispatch: 'action -> unit
  ; store: 'state Callbag.t }

module Internal = struct
  type ('state, 'action) t

  external make:
    ('state -> 'action -> 'state [@bs.uncurry]) -> 'state ->
    ('state, 'action) t = "createStore" [@@bs.module "callbag-store"]

  external getState: ('state, 'action) t -> unit -> 'state = "" [@@bs.send]
  external dispatch: ('state, 'action) t -> 'action -> unit = "" [@@bs.send]
  external store: ('state, 'action) t -> 'state Callbag.t = "" [@@bs.get]
end

let make reducer initial_state =
  let store = Internal.make reducer initial_state in
  { get_state = (fun () -> Internal.getState store ())
  ; dispatch = (fun action -> Internal.dispatch store action)
  ; store = Internal.store store }

type ('state, 'action) store =
  { getState : unit -> 'state
  ; dispatch : 'action -> unit
  ; store : 'state Callbag.t
  }

val make : ('state -> 'action -> 'state) -> 'state -> ('state, 'action) store

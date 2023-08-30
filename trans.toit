import .i_transition show *

class Trans :
  
  event_/int := ?
  state_/int := ?
  functor_/ITransition := ?

  constructor .event_ .state_ .functor_ :

  event -> int :
    return event_

  state -> int :
    return state_

  functor -> ITransition :
    return functor_
    
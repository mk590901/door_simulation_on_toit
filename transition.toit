import .i_transition show *

class Transition :
  
  state_/int := ?
  method_/ITransition := ?

  constructor .state_ .method_ :

  state :
    return state_

  method :
    return method_
    
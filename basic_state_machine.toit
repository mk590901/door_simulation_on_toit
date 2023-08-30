//  basic_state_machine.toit
abstract class BasicStateMachine :
  states_/Map := {:}
  currentState_/int := ?
  
  constructor .currentState_/int :
    create

  abstract create -> none
  abstract publish state/int -> none
  abstract getStateName state/int -> string
  abstract getEventName event/int -> string

  setState state/int -> none :
    currentState_ = state

  getState -> int :
    return currentState_ 

  dispatch event/int -> none :
    currentState   := states_[currentState_]
    if (currentState == null or currentState.size == 0) :
      print("? Failed to get container for $(getStateName currentState_)")
      return
 
    transition := currentState.transition event
    if (transition == null) :
       print("? Failed to get transition for event [$(getEventName event)] and state [$(getStateName currentState_)]")
       return
    
    setState transition.state
    method := transition.method
    method.execute

    publish currentState_


    
      


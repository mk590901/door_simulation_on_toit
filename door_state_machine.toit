import .trans show *
import .state show *
import .door_fun_collection show *
import .basic_state_machine show *
import .timersEngineImpl show *

//  Notifiers
class tOpeningNotifier implements INotifier :
  stateMachine_/DoorStateMachine := ?
  constructor .stateMachine_ :
  start :
    print "($time) [Opening] @start"

  final :
    print "($time) [Opening] @final"
    stateMachine_.dispatch DoorStateMachine.E_OPENING

class tClosingNotifier implements INotifier :
  stateMachine_/DoorStateMachine := ?
  constructor .stateMachine_ :
  start :
    print "($time) [Closing] @start" 
  
  final :
    print "($time) [Closing] @final" 
    stateMachine_.dispatch DoorStateMachine.E_CLOSING

class tAutoClosingNotifier implements INotifier :
  stateMachine_/DoorStateMachine := ?
  constructor .stateMachine_ :
  start :
    print "($time) [AutoClosing] @start" 

  final :
    print "($time) [AutoClosing] @final" 
    stateMachine_.dispatch DoorStateMachine.E_CLOSE

class DoorStateMachine extends BasicStateMachine :

// States
  static S_OPENED   /int := 0
  static S_CLOSED   /int := 1
  static S_OPENING  /int := 2
  static S_CLOSING  /int := 3

// Events 
  static E_OPEN     /int := 0
  static E_CLOSE    /int := 1
  static E_OPENING  /int := 2
  static E_CLOSING  /int := 3

  static states_descr_ := { S_OPENED    : "DOOR IS OPENED",
                            S_CLOSED    : "DOOR IS CLOSED",
                            S_OPENING   : "DOOR IS OPENING",
                            S_CLOSING   : "DOOR IS CLOSING"
  }

  static events_descr_ := { E_OPEN      : "open door",
                            E_CLOSE     : "close door",
                            E_OPENING   : "opening door",
                            E_CLOSING   : "closing door"
  }

  timersEngine_ := TimersEngine 10

  constructor state/int :
    super state
    
  timersEngine :
    return timersEngine_

  create :
    states_[S_OPENED]   = State [Trans E_CLOSE          S_CLOSING (Closing      this)]
    states_[S_CLOSING]  = State [Trans E_CLOSING        S_CLOSED  (Closed       this),
                                 Trans E_OPEN           S_OPENING (Opening      this)]                         
    states_[S_CLOSED]   = State [Trans E_OPEN           S_OPENING (Opening      this)]
    states_[S_OPENING]  = State [Trans E_OPENING        S_OPENED  (Opened       this)]

    timersEngine_.create "tO" 3000 (tOpeningNotifier this)
    timersEngine_.create "tC" 2000 (tClosingNotifier this)
    timersEngine_.create "tA" 2500 (tAutoClosingNotifier this)
 
  publish publishState/int :
    print ("($time) [State]->$(getStateName publishState)")

  getStateName state/int -> string :
    return states_descr_[state]

  getEventName event/int -> string :
    return events_descr_[event]

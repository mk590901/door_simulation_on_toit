import .i_transition
import .door_state_machine
import .timersEngineImpl show *

class Closing implements ITransition :
  stateMachine_/DoorStateMachine := ?
  constructor .stateMachine_ :
  execute -> none :
    print ("($time) @Closing  - start")
    if (stateMachine_ != null) :
      stateMachine_.timersEngine.close "tA"
      stateMachine_.timersEngine.close "tO"
      stateMachine_.timersEngine.run "tC"

class Opening implements ITransition :
  stateMachine_/DoorStateMachine := ?
  constructor .stateMachine_ :
  execute -> none :
    print ("($time) @Opening  - start");
    if (stateMachine_ != null) :
      stateMachine_.timersEngine.close "tC"
      stateMachine_.timersEngine.close "tA"
      stateMachine_.timersEngine.run "tO"

class Closed implements ITransition :
  stateMachine_/DoorStateMachine := ?
  constructor .stateMachine_ :
  execute -> none :
    print ("($time) @Closed   - final")

class Opened implements ITransition :
  stateMachine_/DoorStateMachine := ?
  constructor .stateMachine_ :
  execute -> none :
    print ("($time) @Opened   - final");
    if (stateMachine_ != null) :
      stateMachine_.timersEngine.close "tC"
      stateMachine_.timersEngine.close "tO"
      stateMachine_.timersEngine.run "tA"


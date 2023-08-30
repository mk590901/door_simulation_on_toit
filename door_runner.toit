import .door_state_machine show *

main :

  doorStateMachine := DoorStateMachine DoorStateMachine.S_OPENED
  doorStateMachine.dispatch DoorStateMachine.E_CLOSE
  sleep (Duration --ms=1200)
  print ("******* AFTER SLEEP 1200 *******")
  doorStateMachine.dispatch DoorStateMachine.E_CLOSE
  doorStateMachine.dispatch DoorStateMachine.E_OPEN

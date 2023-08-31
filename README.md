# Door simulation on toit
![hiletgo_esp32_mini](https://github.com/mk590901/door_simulation_on_toit/assets/125393245/1f8acbf2-a3f9-483f-9b73-47edb84f994c)
# Introduction
The reason for writing this application was to try to show how can create managed code app uses object-oriented approach and that will run on a controller with more than limited resources.

An application written in the toit language (https://toit.io/) is a simulator of an automatically opening/closing door. The principle of operation is described by state machine, presented below:

![door](https://github.com/mk590901/door_simulation_on_toit/assets/125393245/9e25e66b-e0e5-4d98-bc1b-510ae96672b5)

I.e. the door can be opened, closed and attempted to be opened at the moment it closes, because opening and closing  take time.

# Application structure
An application is a set of classes that implement the idea outlined above in the Introduction.

## Class State        *(state.toit)*
The class contains a container of objects of type ***Transition***. Each state corresponds to a set of transitions from this state to other states under the influence of events.

## Class Transition        *(transition.toit)*
The object of the ***Transition*** class contains a pair: state to which to transition, and an object with the ***ITransition*** interface, the 'execute'' method to be called on the transition.

## Class Trans        *(trans.toit)*
This class describes the transition of the state machine from the current state to another under the influence of some event. In fact, this class is a wrapper for describing the transfer. In the constructor of the ***State*** class, the elements of the ***Trans*** object are converted into container of transitions.

## Interface ITransition        *(i_transition.toit)*
The ***execute*** function without parameters. Parameters or additional attributes for ***execute*** an be in the class that implements the interface.

## Class BasicStateMachine        *(basic_state_machine.toit)*
This abstract class implements the transition of the state machine from one state to another under the influence of the given event. If the transition is valid, then the transition's function is called when. The basic class also delegates to the inheritance class to implement several additional functions: ***create***, ***publish***, ***getStateName*** and ***getEventName***. In this case, inheritance class is the ***DoorStateMachine*** class.

## Class DoorStateMachine        *(door_state_machine.toit)*
This class inherited from basic class ***BasicStateMachine***, implements the logic described in the __Introduction__. Pay attention to the ***create*** method: in fact, this is the description of __state machine__. The class also contains an instance of object of type ***TimersEngine***. This class allows to create several timers that are used by the application to simulate time delays when opening and closing a door.

## Interface INotifier        *(timersEngineImpl.toit)*
Describes the behavior of an object with ***start*** and ***final*** functions. In this case, object is used in a timer. The start of the timer is accompanied by a call to the start method, the stop leads to the call of the final method.

## Class Timer        *(timersEngineImpl.toit)*
Contains identifier and notifier. The latter implements the ***start*** and ***final*** commands of the timer.

## Class TimersEngine        *(timersEngineImpl.toit)*
Contains a container of timers, Allows to add, remove or start a named timer, as well as reset it by marking it as inactivated. The class contains a __task__ (https://docs.toit.io/language/tasks) in terms of __toit__, which runs when there are no active timers and exits automatically when all running timers become inactive. Pay attention to two functions: ***run_periodically*** and ***run_periodically_in_task***. They are what make the class work. These seven lines of code are not for the weak-minded the mournful-minded like me. The secret of using these functions was shared with me by ***Florian Loitsch*** (https://github.com/floitsch), one of the creators of the language, for which I am especially grateful to him.

## main        *(door_runner.toit)*
And finally the main module, which creates the ***DoorStateMachine***, initiates it and runs the simulation.


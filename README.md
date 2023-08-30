# Door simulation on toit
# Introduction
The reason for writing this application was to try to show how can create managed code app uses object-oriented approach and that will run on a controller with more than limited resources.

An application written in the toit language (https://toit.io/) is a simulator of an automatically opening/closing door. The principle of operation is described by state machine, presented below:

![door](https://github.com/mk590901/door_simulation_on_toit/assets/125393245/9e25e66b-e0e5-4d98-bc1b-510ae96672b5)

I.e. the door can be opened, closed and attempted to be opened at the moment it closes, because opening and closing  take time.

# Application structure
An application is a set of classes that implement the idea outlined above in the Introduction.

## Class State
The class contains a container of objects of type Transition. Each state corresponds to a set of transitions from this state to other states under the influence of events.

## Class Transition
The object of the Transition class contains a pair: state to which to transition, and an object with the ITransition interface, the 'execute'' method to be called on the transition.

## Class Trans
This class describes the transition of the state machine from the current state to another under the influence of some event. In the constructor of the State class, the elements of the Trans object are converted into container of transitions.

## Interface ITransition.
The 'execute' function without parameters. Parameters or additional attributes for 'execute' function can be in the class that implements the interface.

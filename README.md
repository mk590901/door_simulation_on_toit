# Door simulation on toit
# Introduction
The reason for writing this application was to try to show how can create managed code app uses object-oriented approach and that will run on a controller with more than limited resources.

An application written in the toit language (https://toit.io/) is a simulator of an automatically opening/closing door. The principle of operation is described by state machine, presented below:

![door](https://github.com/mk590901/door_simulation_on_toit/assets/125393245/9e25e66b-e0e5-4d98-bc1b-510ae96672b5)

I.e. the door can be opened, closed and attempted to be opened at the moment it closes, because opening and closing  take time.



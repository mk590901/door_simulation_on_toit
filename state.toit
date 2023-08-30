import .i_transition show *
import .transition show *

class State :
  
  container_/Map := {:}

  constructor collection/List :
    collection.do :
      container_[it.event] = Transition it.state it.functor

  transition event/int -> Transition? :
    return container_.contains event ? container_[event] : null

  size -> int :
    return container_.size


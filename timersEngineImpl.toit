time -> string :
  time := Time.now.local
  ms := time.ns / Duration.NANOSECONDS_PER_MILLISECOND
  precise_ms := "$(%02d time.h):$(%02d time.m):$(%02d time.s).$(%03d ms)"
  return precise_ms

interface INotifier :
  start -> none
  final -> none

class Timer :
  start_    := null
  ident_    := null
  notifier_ := null
  delay_    := 0
  
  constructor _ident/string _delay/int _notifier/INotifier:
    ident_      = _ident
    delay_      = _delay
    notifier_   = _notifier

  ident :
    return ident_

  delay :
    return delay_

  start :
    start_ = Time.now.local.time
    notifier_.start

  final :
    notifier_.final

  reset :
    start_ = null

  descr :
    return ident_ + "/" + "$(%03d delay_)"

/// Runs the given $block periodically while the block returns true.
run_periodically duration [block] :
  duration.periodic :
    should_continue_running := block.call
    if not should_continue_running: return

run_periodically_in_task duration callback/Lambda:
  return task::
    run_periodically duration: callback.call

class TimersEngine :
  interval_ms   := 0
  task_         := null
  container_    := {:}

  constructor _interval_ms :
    interval_ms = _interval_ms

  create _ident/string _delay/int _notifier/INotifier-> bool : 
    timer := Timer _ident _delay _notifier
    if (container_.contains _ident) :
      return false
    container_[_ident] = timer
    return true

  delete _ident/string -> bool : 
    if (container_.contains _ident) :
      container_.remove _ident
      return true
    return false

  size -> int :
    return container_.size

  start timerIdent_ :
    print "($time) [Start timer $timerIdent_]"
    interval := Duration --ms = interval_ms
    task_ = run_periodically_in_task interval::
      container_.do : | ident |
        timer := container_[ident]
        if (timer.start_ != null) :
          if (timer.start_.to_now.in_ms >= timer.delay) :
            timer.final
            timer.reset
      if (numberTimers == 0) :
        final ": close engine"
      true  // Return value of the block.

  numberTimers -> int :
    result := 0
    container_.do : | ident |
      timer := container_[ident]
      if (timer.start_ != null) :
        result++
    return result

  final timerIdent_ :
    print "($time) [Final timer $timerIdent_]"
    task_.cancel
    task_ = null

  run ident/string :
    timer := container_[ident]
    if (timer != null) :
      if (task_ == null) :
        start ident // start Engine
      timer.start

  close ident/string :
    timer := container_[ident]
    if (timer.start_ != null) :
      timer.reset

part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class InitialTimerState extends TimerState {
  const InitialTimerState(duration) : super(duration);
}

class TickingTimerState extends TimerState {
  const TickingTimerState(int duration) : super(duration);
}

class CompletedTimerState extends TimerState {
  const CompletedTimerState() : super(0);
}

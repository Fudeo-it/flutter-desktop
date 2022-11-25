part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class StartTimerEvent extends TimerEvent {
  final int duration;
  const StartTimerEvent(this.duration);
}

class ResetTimerEvent extends TimerEvent {
  const ResetTimerEvent();
}

class TickTimerEvent extends TimerEvent {
  final int duration;
  const TickTimerEvent(this.duration);

  @override
  List<Object> get props => [duration];
}

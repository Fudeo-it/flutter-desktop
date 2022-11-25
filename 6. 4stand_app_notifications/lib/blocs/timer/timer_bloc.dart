import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  //static const _duration = 60 * 60;
  static const _duration = 5;


  StreamSubscription<int>? _tickerSubscription;

  TimerBloc() : super(const InitialTimerState(_duration)) {
    on<StartTimerEvent>(_onStarted);
    on<TickTimerEvent>(_onTicked);
    on<ResetTimerEvent>(_onReset);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void start() => add(const StartTimerEvent(_duration));

  void stop() => add(const ResetTimerEvent());

  void _onStarted(StartTimerEvent event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(TickingTimerState(event.duration));

    _tickerSubscription = Stream<int>.periodic(
            const Duration(seconds: 1), (count) => event.duration - count - 1)
        .take(event.duration)
        .listen((duration) => add(TickTimerEvent(duration)));
  }

  void _onTicked(TickTimerEvent event, Emitter<TimerState> emit) {
    emit(
      event.duration > 0
          ? TickingTimerState(event.duration)
          : const CompletedTimerState(),
    );
  }

  void _onReset(ResetTimerEvent event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const InitialTimerState(_duration));
  }
}

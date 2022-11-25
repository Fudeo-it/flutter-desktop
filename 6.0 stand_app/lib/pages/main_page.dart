import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:stand_app/blocs/timer/timer_bloc.dart';
import 'package:stand_app/widgets/ticker_widget.dart';
import 'package:stand_app/widgets/walk_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<TimerBloc, TimerState>(
          builder: (context, state) => SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Lottie.asset(
                  'assets/animations/walking.json',
                  repeat: state is! TickingTimerState,
                  width: double.maxFinite,
                  height: double.maxFinite,
                  fit: BoxFit.cover,
                  animate: state is! TickingTimerState,
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  top: state is TickingTimerState ? 48 : -200,
                  child: TickerWidget(state.duration),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  left: state is CompletedTimerState
                      ? (MediaQuery.of(context).size.width - 450) / 2
                      : -1000,
                  child: WalkWidget(
                    onReset: context.read<TimerBloc>().start,
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  left: 48,
                  bottom: state is InitialTimerState ? 48 : -200,
                  right: 48,
                  child: ElevatedButton(
                    onPressed: context.read<TimerBloc>().start,
                    child: const Text('Start'),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  left: 16,
                  bottom: state is TickingTimerState ? 48 : -200,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: context.read<TimerBloc>().stop,
                    child: const Text('Stop'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

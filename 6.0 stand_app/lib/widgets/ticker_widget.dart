import 'package:flutter/material.dart';

class TickerWidget extends StatelessWidget {
  final int duration;

  const TickerWidget(this.duration, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            _formattedTime,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      );

  String get _formattedTime {
    final seconds = duration % 60;
    final minutes = (duration - seconds) ~/ 60;

    final minutesString = '$minutes'.padLeft(2, '0');
    final secondsString = '$seconds'.padLeft(2, '0');

    return '$minutesString:$secondsString';
  }
}

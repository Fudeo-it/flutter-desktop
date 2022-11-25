import 'package:flutter/material.dart';

class WalkWidget extends StatelessWidget {
  final GestureTapCallback onReset;

  const WalkWidget({
    Key? key,
    required this.onReset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        color: Colors.greenAccent[100],
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Go for a walk!',
                style: Theme.of(context).textTheme.headline2,
              ),
              ElevatedButton(
                onPressed: onReset,
                child: const Text('Reset'),
              ),
            ],
          ),
        ),
      );
}

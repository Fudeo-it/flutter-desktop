import 'package:flutter/material.dart';

class ExceptionWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const ExceptionWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.black),
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      );
}

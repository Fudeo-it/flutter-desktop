import 'package:macos_sign_up/cubits/dark_theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ThemeSelectorWidgetBuilder = Widget Function(
  BuildContext context,
  ThemeMode mode,
);

class ThemeSelector extends StatelessWidget {
  final ThemeSelectorWidgetBuilder builder;

  const ThemeSelector({required this.builder, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<DarkThemeCubit, bool>(
        builder: (context, state) => builder(
          context,
          state ? ThemeMode.dark : ThemeMode.light,
        ),
      );
}

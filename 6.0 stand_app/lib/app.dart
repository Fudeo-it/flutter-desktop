import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stand_app/blocs/timer/timer_bloc.dart';
import 'package:stand_app/pages/main_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => TimerBloc(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StandApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: const TextTheme(
          headline2: TextStyle(color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
              ),
              textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              padding: const EdgeInsets.all(24)),
        ),
        cardTheme: CardTheme(
          elevation: 16,
          color: Colors.redAccent[100]!,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(56),
            ),
          ),
        ),
      ),
      home: const MainPage(),
    ),
  );
}

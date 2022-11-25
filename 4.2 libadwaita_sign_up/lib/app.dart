import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita_sign_up/cubits/dark_theme_cubit.dart';
import 'package:libadwaita_sign_up/pages/main_page.dart';
import 'package:libadwaita_sign_up/widgets/theme_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => DarkThemeCubit(),
        child: ThemeSelector(builder: (context, theme) {
          return MaterialApp(
            title: 'Libadwaita Sign Up',
            themeMode: theme,
            debugShowCheckedModeBanner: false,
            color: Colors.blue,
            theme: AdwaitaThemeData.light(),
            darkTheme: AdwaitaThemeData.dark(),
            home: const MainPage(),
          );
        }),
      );
}

import 'package:fluent_sign_up/cubits/dark_theme_cubit.dart';
import 'package:fluent_sign_up/pages/main_page.dart';
import 'package:fluent_sign_up/widgets/theme_selector.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => DarkThemeCubit(),
        child: ThemeSelector(builder: (context, theme) {
          return FluentApp(
            title: 'Fluent Sign Up',
            themeMode: theme,
            debugShowCheckedModeBanner: false,
            color: Colors.blue,
            theme: ThemeData(
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            home: const MainPage(),
          );
        }),
      );
}

import 'package:flutter/cupertino.dart';
import 'package:macos_sign_up/cubits/dark_theme_cubit.dart';
import 'package:macos_sign_up/pages/main_page.dart';
import 'package:macos_sign_up/widgets/theme_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macos_ui/macos_ui.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => DarkThemeCubit(),
        child: ThemeSelector(builder: (context, theme) {
          return MacosApp(
            title: 'macOS Sign Up',
            themeMode: theme,
            debugShowCheckedModeBanner: false,
            theme: MacosThemeData.light(),
            darkTheme: MacosThemeData.dark(),
            home: const MainPage(),
          );
        }),
      );
}

import 'package:fluent_sign_up/cubits/dark_theme_cubit.dart';
import 'package:fluent_sign_up/pages/empty_page.dart';
import 'package:fluent_sign_up/pages/sign_up_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) => NavigationView(
        appBar: NavigationAppBar(
          automaticallyImplyLeading: false,
          title: const Text('Sign Up'),
          actions: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocBuilder<DarkThemeCubit, bool>(
                builder: (context, darkModeEnabled) {
                  return ToggleSwitch(
                    content: const Text('Dark Mode'),
                    checked: darkModeEnabled,
                    onChanged: (_) => context.read<DarkThemeCubit>().toggle(),
                  );
                },
              ),
            ],
          ),
        ),
        pane: NavigationPane(
            selected: _selectedIndex,
            onChanged: (index) => setState(() {
                  _selectedIndex = index;
                }),
            items: [
              PaneItem(
                icon: const Icon(FluentIcons.user_sync),
                title: const Text('Sign Up'),
                body: const SignUpPage(),
              ),
              PaneItem(
                icon: const Icon(FluentIcons.home),
                title: const Text('Empty'),
                body: const EmptyPage(),
              ),
            ]),
      );
}

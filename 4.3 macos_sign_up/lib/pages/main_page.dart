import 'package:flutter/cupertino.dart';
import 'package:macos_sign_up/cubits/dark_theme_cubit.dart';
import 'package:macos_sign_up/pages/empty_page.dart';
import 'package:macos_sign_up/pages/sign_up_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macos_ui/macos_ui.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) => MacosWindow(
        sidebar: Sidebar(
          minWidth: 200,
          builder: (context, controller) {
            return SidebarItems(
              currentIndex: _selectedIndex,
              onChanged: (index) => setState(() {
                _selectedIndex = index;
              }),
              scrollController: controller,
              itemSize: SidebarItemSize.large,
              items: const [
                SidebarItem(
                  leading: Icon(CupertinoIcons.arrow_up_circle_fill),
                  label: Text('Sign Up'),
                ),
                SidebarItem(
                  leading: Icon(CupertinoIcons.airplane),
                  label: Text('Empty'),
                ),
              ],
            );
          },
          bottom: BlocBuilder<DarkThemeCubit, bool>(
            builder: (context, darkThemeEnabled) {
              return MacosListTile(
                leading: MacosSwitch(
                  value: darkThemeEnabled,
                  onChanged: (_) => context.read<DarkThemeCubit>().toggle(),
                ),
                title: const Text('Dark Mode'),
              );
            },
          ),
        ),
    child: IndexedStack(
      index: _selectedIndex,
      children: const [
        SignUpPage(),
        EmptyPage(),
      ],
    ),
      );
}

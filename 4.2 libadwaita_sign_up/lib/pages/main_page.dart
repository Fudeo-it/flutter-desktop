import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_bitsdojo/libadwaita_bitsdojo.dart';
import 'package:libadwaita_sign_up/cubits/dark_theme_cubit.dart';
import 'package:libadwaita_sign_up/pages/empty_page.dart';
import 'package:libadwaita_sign_up/pages/sign_up_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  late FlapController _flapController;

  @override
  void initState() {
    _flapController = FlapController();

    _flapController.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) => AdwScaffold(
        flapController: _flapController,
        actions: AdwActions().bitsdojo,
        title: const Text('Sign Up'),
        start: [
          AdwHeaderButton(
            icon: const Icon(Icons.view_sidebar_outlined, size: 20),
            isActive: _flapController.isOpen,
            onPressed: () => _flapController.toggle(),
          ),
          AdwHeaderButton(
            icon: const Icon(Icons.nightlight_round, size: 16),
            onPressed: () => context.read<DarkThemeCubit>().toggle(),
          ),
        ],
        flap: (isDrawer) => AdwSidebar(
          currentIndex: _selectedIndex,
          onSelected: (index) => setState(() => _selectedIndex = index),
          isDrawer: isDrawer,
          children: const [
            AdwSidebarItem(leading: Icon(Icons.people), label: 'Sign Up'),
            AdwSidebarItem(
              leading: Icon(Icons.settings),
              label: 'Empty',
            ),
          ],
        ),
        body: AdwViewStack(
          animationDuration: const Duration(milliseconds: 250),
          index: _selectedIndex,
          children: const [
            SignUpPage(),
            EmptyPage(),
          ],
        ),
      );
}

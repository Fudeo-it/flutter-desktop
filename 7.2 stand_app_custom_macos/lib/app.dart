import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:stand_app/blocs/timer/timer_bloc.dart';
import 'package:stand_app/pages/main_page.dart';
import 'package:system_tray/system_tray.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(create: (_) => AppWindow()),
          Provider(
            create: (context) {
              final appWindow = context.read<AppWindow>();
              final systemTray = SystemTray();

              systemTray.initSystemTray(
                title: 'StandApp',
                iconPath: Platform.isWindows
                    ? 'assets/icons/icon.ico'
                    : 'assets/icons/icon.png',
              );

              systemTray.registerSystemTrayEventHandler((eventName) {
                if (eventName == kSystemTrayEventClick) {
                  Platform.isWindows
                      ? appWindow.show()
                      : systemTray.popUpContextMenu();
                } else if (eventName == kSystemTrayEventRightClick) {
                  Platform.isWindows
                      ? systemTray.popUpContextMenu()
                      : appWindow.show();
                }
              });

              updateSystemTray(appWindow, systemTray);

              return systemTray;
            },
            lazy: false,
          ),
        ],
        child: BlocProvider(
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
        ),
      );

  static Future<void> updateSystemTray(
    AppWindow appWindow,
    SystemTray systemTray, {
    GestureTapCallback? onReset,
  }) async {
    final menu = Menu();
    await menu.buildFrom(
      [
        if (onReset != null) ...[
          MenuItemLabel(label: 'Reset', onClicked: (_) => onReset()),
          MenuSeparator(),
        ],
        MenuItemLabel(label: 'Show', onClicked: (_) => appWindow.show()),
        MenuItemLabel(label: 'Hide', onClicked: (_) => appWindow.hide()),
        MenuItemLabel(label: 'Exit', onClicked: (_) => appWindow.close()),
      ],
    );

    await systemTray.setContextMenu(menu);
  }
}

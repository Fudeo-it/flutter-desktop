import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:stand_app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await localNotifier.setup(
    appName: 'StandApp',
    shortcutPolicy: ShortcutPolicy.requireCreate,
  );

  runApp(const App());
}

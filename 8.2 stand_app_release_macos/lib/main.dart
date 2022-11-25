import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stand_app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final packageInfo = await PackageInfo.fromPlatform();

  await localNotifier.setup(
    appName: packageInfo.appName,
    shortcutPolicy: ShortcutPolicy.requireCreate,
  );

  runApp(const App());
}

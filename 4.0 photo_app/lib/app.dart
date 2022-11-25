import 'package:flutter/material.dart';
import 'package:photo_app/pages/photos_page.dart';
import 'package:photo_app/repositories/photo_repository.dart';
import 'package:photo_app/services/photo_service.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(
            create: (_) => PhotoService(),
          ),
          Provider(
            create: (context) => PhotoRepository(
              photoService: context.read(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Photo App',
          themeMode: ThemeMode.dark,
          theme: ThemeData(
            brightness: Brightness.dark,
            cardTheme: const CardTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
          home: const PhotosPage(),
        ),
      );
}

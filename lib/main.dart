import 'package:flutter/material.dart';
import 'package:jenil_publicfetchapi_project/src/core/theme/theme.dart';
import 'package:jenil_publicfetchapi_project/src/features/splash/presentation/screens/splash_screen.dart';
import 'package:jenil_publicfetchapi_project/src/core/utils/local_database_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabaseHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Article App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const SplashScreen(),
    );
  }
}

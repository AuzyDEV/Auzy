import 'package:flutter/material.dart';
import 'index.dart';
import 'themes/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterAppTheme.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  
  @override
  State<MyApp> createState() => _MyAppState();
  static _MyAppState of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  ThemeMode _themeMode = FlutterAppTheme.themeMode;
  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
    _themeMode = mode;
    FlutterAppTheme.saveThemeMode(mode);
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter-Skeleton',
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(brightness: Brightness.light),
      home: SigninWidget(),
    );
  }
}

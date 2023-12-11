import 'package:contact_list/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contact_list/theme/theme.dart';
import 'package:flutter_driver/driver_extension.dart';
void main() {
  enableFlutterDriverExtension();
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(
    child: MaterialApp(
      darkTheme: darkTheme,
      theme: theme,
      home: const SplashScreen(),
      themeMode: ThemeMode.system,
    ),
  ));
}

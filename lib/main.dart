import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/campus_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set immersive status bar overlay
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const SmartCampusNavigatorApp());
}

class SmartCampusNavigatorApp extends StatelessWidget {
  const SmartCampusNavigatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Campus Navigator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A), // MACE Collegiate Navy Blue
          brightness: Brightness.light,
          primary: const Color(0xFF1E3A8A),
          secondary: const Color(0xFF16A34A),
          tertiary: const Color(0xFFD97706),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
        ),
        chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A),
          brightness: Brightness.dark,
          primary: const Color(0xFF38BDF8),
          secondary: const Color(0xFF4ADE80),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const CampusHomeScreen(),
    );
  }
}

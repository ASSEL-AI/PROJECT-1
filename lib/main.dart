import 'package:flutter/material.dart';
import 'package:hemmah_app/screens/home_screen.dart';
import 'package:hemmah_app/screens/main_container.dart';
import 'package:hemmah_app/screens/onboarding_screen.dart';
import 'package:hemmah_app/screens/otp_screen.dart';
import 'package:hemmah_app/screens/settings_screen.dart';
import 'package:hemmah_app/screens/splash_screen.dart';
import 'package:hemmah_app/screens/welcome_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://wszjbjladhaqnlmsktfn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndzempiamxhZGhhcW5sbXNrdGZuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc4MTY2NzAsImV4cCI6MjA2MzM5MjY3MH0.vv6jgA8cDJb8bC0XHhx2WZS53rF-lmG78tI5XppX-q0',
  );

  runApp(const HemmahApp());
}

class HemmahApp extends StatelessWidget {
  const HemmahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'همة',
      theme: ThemeData(fontFamily: 'CascadiaMono'),
      home: const MainContainer(),
    );
  }
}

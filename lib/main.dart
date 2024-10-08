import 'package:audio_player_/controller/SignupController.dart';
import 'package:audio_player_/views/HomePage.dart';
import 'package:audio_player_/views/onboardingScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/song_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SongProvider()),
        ChangeNotifierProvider(create: (context) => SignupController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // Set initial route
      routes: {
        '/': (context) => OnboardingScreen(), // Your initial screen
        '/home': (context) => HomeScreen(), // Your home screen
      },
      // Optional: Handle unknown routes
      
    );
  }
}

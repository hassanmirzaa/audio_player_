import 'package:audio_player_/views/onboardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/song_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SongProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Player',
      home: OnboardingScreen(), // Your home screen
    );
  }
}

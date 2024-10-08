import 'dart:ui';
import 'package:audio_player_/models/SongsModels.dart';
import 'package:flutter/material.dart';

class MusicPlayerScreen extends StatelessWidget {
  final Song song;

  const MusicPlayerScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: height,
              width: width,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/office_girl.jpg',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () {
                        // Share functionality
                      },
                    ),
                  ],
                ),
              ),
              Hero(
                tag: 'song-${song.title}',
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  height: height * 0.4,
                  width: height * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.0),
                    image: DecorationImage(
                      image: AssetImage('assets/office_girl.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const Text(
                'Instant Crush',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'feat. Julian Casablancas',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.shuffle, color: Colors.white),
                        Icon(Icons.skip_previous, color: Colors.white),
                        CircleAvatar(
                          backgroundColor: Colors.orangeAccent,
                          radius: 30,
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        Icon(Icons.skip_next, color: Colors.white),
                        Icon(Icons.repeat, color: Colors.white),
                      ],
                    ),
                    Slider(
                      value: 0.5,
                      onChanged: (value) {},
                      activeColor: Colors.orangeAccent,
                      inactiveColor: Colors.white38,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ],
      ),
    );
  }
}
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds
    ].join(':');
  }

  @override
  void initState() {
    super.initState();

    audioPlayer.playerStateStream.listen((state) {
      setState(() {
        isPlaying = state.playing;
      });
    });

    audioPlayer.durationStream.listen((newDuration) {
      setState(() {
        duration = newDuration ?? Duration.zero;
      });
    });

    audioPlayer.positionStream.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              child: Stack(
                children: [
                  Container(
                    height: height,
                    width: width,
                    child: Image.asset(
                      'assets/apple-logo.png',
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: const Color(0xffff8303),
                          radius: 25,
                          child: Icon(
                            Icons.adaptive.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Wrap(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const CircleAvatar(
                              backgroundColor: Color(0xffff8303),
                              radius: 25,
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              backgroundColor: const Color(0xffff8303),
                              radius: 25,
                              child: Icon(
                                Icons.adaptive.share_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.15,
                  ),
                  Container(
                    height: height * 0.4,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffff8303), width: 5),
                        shape: BoxShape.circle,
                        color: Colors.white),
                    child: Image.asset(
                      'assets/apple-logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  Text(
                    'Title',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'Subtitle',
                    style: TextStyle(fontSize: 20),
                  ),
                  Slider(
                    thumbColor: Color(0xffff8303),
                    overlayColor: WidgetStatePropertyAll(Color(0xffff8303),),
                    activeColor: Color(0xffff8303),
                    value: position.inSeconds.toDouble(),
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    onChanged: (value) async {
                      final newPosition = Duration(seconds: value.toInt());
                      await audioPlayer.seek(newPosition);
                      await audioPlayer.play();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatTime(position)),
                      Text(formatTime(duration)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_previous_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [
                              Color(0xffffaf42),
                              Color(0xffff8303)
                            ])),
                        child: IconButton(
                          onPressed: () async {
                            if (isPlaying) {
                              await audioPlayer.pause();
                            } else {
                              String url = 'https://cdn.islamic.network/quran/audio-surah/128/ar.alafasy/1.mp3';
                              await audioPlayer.setUrl(url);
                              await audioPlayer.play();
                            }
                          },
                          icon: Icon(
                            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_next_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

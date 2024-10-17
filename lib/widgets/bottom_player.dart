/* bottom_player.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audio_player_/controller/song_provider.dart';
import 'package:just_audio/just_audio.dart';

class BottomPlayer extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const BottomPlayer({Key? key, required this.audioPlayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);

    if (songProvider.currentSong == null) {
      return SizedBox.shrink(); // Return an empty widget if no song is playing
    }

    final currentSong = songProvider.currentSong!;

    return Container(
      color: Colors.orangeAccent,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              currentSong.imageUrl,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentSong.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  currentSong.artist,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              songProvider.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () {
              if (songProvider.isPlaying) {
                audioPlayer.pause();
              } else {
                audioPlayer.play();
              }
              songProvider.togglePlayPause();
            },
          ),
        ],
      ),
    );
  }
}*/

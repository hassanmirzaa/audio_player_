import 'package:flutter/material.dart';

class Song {
  String name;
  String duration;
  String session;
  bool isFavorite;

  Song({
    required this.name,
    required this.duration,
    required this.session,
    this.isFavorite = false,
  });
}

class SongProvider with ChangeNotifier {
  List<Song> _songs = List.generate(
    20,
    (index) => Song(
      name: 'Song $index',
      duration: '05 minutes',
      session: '01 Session',
    ),
  );

  List<Song> get songs => _songs;

  get favorites => null;

  void toggleFavorite(int index) {
    _songs[index].isFavorite = !_songs[index].isFavorite;
    notifyListeners();
  }
}

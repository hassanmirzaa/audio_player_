class Song {
  final String name;
  final String duration;
  final String session;
  bool isFavorite; // Mutable property

  Song({
    required this.name,
    required this.duration,
    required this.session,
    this.isFavorite = false,
  });
}
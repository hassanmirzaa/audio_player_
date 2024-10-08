import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audio_player_/controller/song_provider.dart';
import 'package:audio_player_/views/MusicPlayerScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // Use FutureBuilder to avoid fetching songs during the build process
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.03),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Songs",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.favorite_border_rounded),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            Expanded(
              // Use FutureBuilder to fetch the songs and handle loading state
              child: FutureBuilder(
                future: Provider.of<SongProvider>(context, listen: false).fetchSongs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Consumer<SongProvider>(
                      builder: (context, songProvider, child) {
                        final songs = songProvider.songs;

                        if (songs.isEmpty) {
                          return const Center(child: Text('No songs available'));
                        }

                        return ListView.builder(
                          itemCount: songs.length,
                          itemBuilder: (context, index) {
                            final song = songs[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MusicPlayerScreen(song: song),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: 'song-${song.title}',
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.orangeAccent,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 2,
                                          color: Colors.black,
                                          offset: Offset(-1, 2),
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  song.imageUrl,
                                                  height: height * 0.08,
                                                  width: width * 0.15,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    song.title,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(song.artist),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  song.isFavorite
                                                      ? Icons.favorite
                                                      : Icons.favorite_border_rounded,
                                                  color: song.isFavorite ? Colors.black : null,
                                                ),
                                                onPressed: () {
                                                  // Ensure to update the favorite status
                                                  Provider.of<SongProvider>(context, listen: false).toggleFavorite(index);
                                                },
                                              ),
                                              const SizedBox(height: 10),
                                              const CircleAvatar(
                                                backgroundColor: Colors.black,
                                                child: Icon(
                                                  Icons.play_arrow_rounded,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

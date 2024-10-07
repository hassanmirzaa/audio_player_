import 'package:audio_player_/controller/song_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.03,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Songs",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  backgroundColor: Colors.orangeAccent,
                  child: Icon(Icons.favorite_border_rounded),
                )
              ],
            ),
            SizedBox(height: height*0.01,),
            Expanded(
              child: Consumer<SongProvider>(
                builder: (context, songProvider, child) {
                  return ListView.builder(
                    itemCount: songProvider.songs.length,
                    itemBuilder: (context, index) {
                      final song = songProvider.songs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.orangeAccent,
                            boxShadow: [
                              const BoxShadow(
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
                                    Image.asset(
                                      'assets/office_girl.jpg',
                                      height: height * 0.08,
                                      width: width * 0.15,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          song.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(song.duration),
                                        const SizedBox(height: 5),
                                        Text(song.session),
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
                                        color: song.isFavorite
                                            ? Colors.black
                                            : null,
                                      ),
                                      onPressed: () {
                                        songProvider.toggleFavorite(index);
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      child: const Icon(Icons.play_arrow_rounded,
                                      color: Colors.white,)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

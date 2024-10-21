import 'dart:convert';
import 'package:audio_player_/models/Chapters_detailsModel.dart';
import 'package:audio_player_/views/MusicPlayerScreen.dart';
import 'package:audio_player_/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearchbar = false;
  TextEditingController searchController = TextEditingController();
  List<Chapters> chapters = [];
  List<Chapters> filteredChapters = [];

  @override
  void initState() {
    super.initState();
    fetchChapters();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchChapters() async {
    final response =
        await http.get(Uri.parse('https://quranapi.pages.dev/api/surah.json'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        chapters = jsonData.map((data) => Chapters.fromJson(data)).toList();
        filteredChapters = chapters;
      });
    } else {
      throw Exception('Failed to load chapters');
    }
  }

  void _filterChapters(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredChapters = chapters;
      } else {
        filteredChapters = chapters.where((chapter) {
          final surahNameLower = chapter.surahName!.toLowerCase();
          final revelationPlaceLower = chapter.revelationPlace!.toLowerCase();
          final searchLower = query.toLowerCase();

          return surahNameLower.contains(searchLower) ||
              revelationPlaceLower.contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xfffd5602), Color(0xffffaf42)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            children: [
                              const Text(
                                'Chapters',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSearchbar = !isSearchbar;
                                  });
                                },
                                icon: const Icon(
                                  Icons.search_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              CircleAvatar(
                                radius: height * 0.027,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite_outline_rounded,
                                    color: Color(0xffff8303),
                                    size: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              CircleAvatar(
                                radius: height * 0.027,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SettingsScreen(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.settings_rounded,
                                    color: Color(0xffff8303),
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.01),
                      AnimatedCrossFade(
                        firstChild: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search Chapters",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            _filterChapters(value);
                          },
                        ),
                        secondChild: const SizedBox(),
                        crossFadeState: isSearchbar
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 300),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              Expanded(
                child: ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: filteredChapters.length,
                  itemBuilder: (context, index) {
                    final chapter = filteredChapters[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MusicPlayerScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: height * 0.1,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xffff8303), Color(0xffffaf42)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                      'assets/apple-logo.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      chapter.surahName ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      chapter.revelationPlace ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        // Implement your favorite toggle logic here
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.favorite_outline,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

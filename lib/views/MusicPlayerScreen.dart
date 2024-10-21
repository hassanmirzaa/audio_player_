import 'dart:ui';

import 'package:flutter/material.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              child: Stack(children: [
                Container(
                  height: Height,
                  width: Width,
                  child: Image.asset(
                    'assets/apple-logo.png',
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                )
              ]),
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
                            width: Width * 0.02,
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
                      )
                    ],
                  ),
                  SizedBox(
                    height: Height * 0.15,
                  ),
                  Container(
                    height: Height * 0.4,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffff8303), width: 5),
                        shape: BoxShape.circle,
                        color: Colors.white),
                    child: Image.asset('assets/apple-logo.png',fit: BoxFit.cover,),
                  ),

                  SizedBox(height: Height*0.05,),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(onPressed: (){}, icon: const Icon(Icons.skip_previous_rounded,size: 30,color: Colors.white,)),

                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [
                            Color(0xffffaf42),
                            Color(0xffff8303)
                          ])
                        ),
                        child: IconButton(onPressed: (){
                          setState(() {
                         isPlaying =! isPlaying;
                          print(isPlaying);
                        });
                        }, icon:  Icon(
                          isPlaying ? 
                          Icons.pause_rounded
                          : Icons.play_arrow_rounded 
                          ,color: Colors.white,size: 35,)),
                      ),

                       IconButton(onPressed: (){
                        
                       }, icon: const Icon(Icons.skip_next_rounded,size: 30,color: Colors.white,)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
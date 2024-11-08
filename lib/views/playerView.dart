import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/raw_model/song.dart';

class PLayerView extends StatelessWidget {
  final Song song;
  final EdgeInsets padding = const EdgeInsets.all(8);
  final Container spacer = Container(width: 16,);
  final Color bg = Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
  final Duration maxDuration;
  final Duration position;
  final bool shuffle;
  final bool repeat;
  final Function() onRepepeatPressed;
  final Function() onShufflePressed;
  final Function() onPlayPausePressed;
  final Function() onRewindPressses;
  final Function() onForwardPressed;
  final Function(double) onPositionChanged;
  final IconData playPause;
   PLayerView({super.key, required this.song, required this.onRepepeatPressed, required this.onShufflePressed, required this.onPlayPausePressed, required this.onRewindPressses, required this.onForwardPressed, required this.maxDuration, required this.position, required this.onPositionChanged, required this.shuffle, required this.repeat, required this.playPause});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(song.title, style: GoogleFonts.signika(fontSize: 18, ),),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),

              child: Image.network(song.thumb, fit: BoxFit.fill,
              height: size.width/2,
              ),
              ),
            const Divider(thickness: 3,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Icon(Icons.ios_share),
                spacer,
                Icon(Icons.menu),
                spacer,
                Icon(Icons.whatshot)
              ],
            ),
            Text(song.artist.name, style: GoogleFonts.signika(color: Colors.redAccent, fontSize: 35),textAlign: TextAlign.center,),
            Text(song.title, style: GoogleFonts.signika(fontSize: 25, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            Card(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  //color: bg.withOpacity(0.75)
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      IconButton(onPressed: onRepepeatPressed, icon: (repeat == false) ? const Icon(Icons.repeat) : const Icon(Icons.repeat_one_on_rounded)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(padding: padding),
                           IconButton(
                              onPressed: onRewindPressses,
                              icon: const Icon(Icons.fast_rewind)
                           ),
                          IconButton(
                              onPressed: onPlayPausePressed,
                              icon:  Icon(playPause)
                          ),
                          IconButton(
                              onPressed: onForwardPressed,
                              icon: const Icon(Icons.fast_forward)
                          ),
                        ],
                      ),
                      IconButton(onPressed: onShufflePressed, icon: (shuffle == false) ? const Icon(Icons.shuffle) : const Icon(Icons.shuffle_on_rounded))
                    ],),
                    Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(readableDuration(Duration(seconds: 0)), style: GoogleFonts.signika(fontSize: 18, color: Colors.red),),
                            Text(readableDuration(position), style: GoogleFonts.signika(fontSize: 18, color: Colors.red),),
                            Text(readableDuration(maxDuration), style: GoogleFonts.signika(fontSize: 18, color: Colors.red),)
                          ],
                        ),
                        Slider(
                          min: 0,
                          max: maxDuration.inSeconds.toDouble(),
                          value: position.inSeconds.toDouble(),
                          onChanged: onPositionChanged,
                          activeColor: Colors.red,
                          inactiveColor: Colors.white,
                          thumbColor: Colors.red,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.speaker),
                Icon(Icons.timer),
                Icon(Icons.whatshot_outlined)
              ],
            )

          ],
        ),
      ),
    );
  }
  String readableDuration(Duration duration){
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    String minuteeStr = (minutes < 10) ? "0$minutes" : minutes.toString();
    String secStr = (seconds < 10) ? "0$seconds" : seconds.toString();
    return minuteeStr+":"+secStr;
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musik_player/models/enums/genre.dart';

import '../controller/playListController.dart';
import '../models/enums/playlists.dart';
import '../models/services/musicHandler.dart';

class GenreCell extends StatelessWidget {
  final Genre genre;
  const GenreCell({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        final playList = MusicHandler().allMusicFromGenre(genre);
        final route = MaterialPageRoute(builder: ((context) => PlayListController(playlist: playList, title: genre.name, type: PlayList.genre)));
        Navigator.push(context, route);
      },
      child: Container(
        width: MediaQuery.of(context).size.width*0.45,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1)
        ),
        child: Center(
          child: Text(genre.name, style: GoogleFonts.signika(fontSize: 20, color: Colors.blueGrey),),
        ),
      ),
    );
  }
}

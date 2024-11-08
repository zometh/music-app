
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musik_player/controller/playerController.dart';
import 'package:musik_player/views/searchMusicView.dart';

import '../models/enums/playlists.dart';
import '../models/raw_model/song.dart';
class PlayListController extends StatelessWidget {
  final List<Song> playlist;
  final String title;
  final PlayList type;
  const PlayListController({super.key, required this.playlist, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(title),
      ),
      body: SafeArea(
        top: true,
          bottom: true,
          child: Column(
            children: [
                  topView(MediaQuery.of(context).size),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index){
                      return SearchMusicView(song: playlist[index], playList: playlist);
                    },
                    separatorBuilder: ((context, index) => const Divider()),
                    itemCount: playlist.length),
              )
            ],
          )
      ),
    );
  }
  Widget topView(Size size){
      switch(type){
        case PlayList.artist: return Column(
          children: [
            Text(playlist.first.artist.name, style: GoogleFonts.signika(fontSize: 35),),
            ClipOval(
              child: Image.network(playlist.first.artist.urlImage, height: 125,),
            )
          ],
        );
        case PlayList.album:
          return Container(
            child: Column(
              children: [
                Image.network(playlist.first.thumb, height: size.height/4,),
                Text(playlist.first.album, style: GoogleFonts.signika(fontSize: 25),),
                Text(playlist.first.artist.name, style: GoogleFonts.signika(fontSize: 16, color: Colors.red),)
                
              ],
            ),

          );
        case PlayList.genre: return Center(
          child: Text(playlist.first.genre.name, style: GoogleFonts.signika(fontSize: 35),),
        );
        default: return Container();
      }
  }
}

import 'package:flutter/material.dart';
import 'package:musik_player/controller/playListController.dart';
import 'package:musik_player/models/enums/playlists.dart';
import 'package:musik_player/models/raw_model/artiste.dart';
import 'package:musik_player/models/services/musicHandler.dart';
class ArtistCircleCell extends StatelessWidget {
  final Artist artist;
  final double heigth;
  const ArtistCircleCell({super.key, required this.artist, required this.heigth});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        final playList = MusicHandler().allMusicFromArtist(artist);
        final route = MaterialPageRoute(builder: ((context) => PlayListController(playlist: playList, title: artist.name, type: PlayList.artist)));
        Navigator.push(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipOval(
          child: Image.network(
            artist.urlImage,
            width: heigth,
            height: heigth,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

}

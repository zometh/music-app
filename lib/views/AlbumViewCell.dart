import 'package:flutter/material.dart';
import 'package:musik_player/controller/playListController.dart';
import 'package:musik_player/models/enums/playlists.dart';
import 'package:musik_player/models/raw_model/album.dart';

class AlbumViewCell extends StatelessWidget {
  final Album album;
  const AlbumViewCell({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        final route = MaterialPageRoute(builder: (context){
          return PlayListController(playlist: album.songs, title: album.title, type: PlayList.album);
        });
        Navigator.push(context, route);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(album.songs[0].thumb, fit: BoxFit.fill,),
      ),
    );
  }
}

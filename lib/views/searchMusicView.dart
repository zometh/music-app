import 'package:flutter/material.dart';

import '../controller/playerController.dart';
import '../models/enums/playlists.dart';
import '../models/raw_model/song.dart';

class SearchMusicView extends StatelessWidget {
  final Song song;
  final List<Song> playList;
  const SearchMusicView({super.key, required this.song, required this.playList});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      title: Text(song.title),
      leading: Image.network(song.thumb),
      trailing: const Icon(Icons.arrow_right),
      onTap: (){
        final route = MaterialPageRoute(builder: (context){
          return  MyPlayerController(songToPlay: song, playList: playList,);
        });
        Navigator.push(context, route);
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musik_player/views/listContainers/albumContainer.dart';
import 'package:musik_player/views/listContainers/artisteContainer.dart';
import 'package:musik_player/views/listContainers/genreContainer.dart';

class MusicView extends StatelessWidget {
  const MusicView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Divider(),
          ArtistContainer(),
          const Divider(),
          AlbumsContainer(),
          const Divider(),
          GenreContainer(),
        ],
      ),
    );
  }
}

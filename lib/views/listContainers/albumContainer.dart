import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musik_player/models/services/musicHandler.dart';
import 'package:musik_player/views/AlbumViewCell.dart';

import '../../models/raw_model/album.dart';
 class AlbumsContainer extends StatelessWidget {
   final List<Album> albums = MusicHandler().allAlbums();
    AlbumsContainer({super.key});

   @override
   Widget build(BuildContext context) {
     return Container(
       child: Column(
         mainAxisSize: MainAxisSize.max,
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text("Albums", style: GoogleFonts.signika(fontSize: 20),),
           Container(
             margin: EdgeInsets.only(left: 40, top: 10),
             height: 300,
             child: GridView.builder(
              scrollDirection: Axis.horizontal,
               itemCount: albums.length,
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   mainAxisSpacing: 10,
                   crossAxisSpacing: 10

                 ),
                 itemBuilder: ((context, index) => AlbumViewCell(album: albums[index]))
             ),
           )
         ],
       ),
     );
   }
 }

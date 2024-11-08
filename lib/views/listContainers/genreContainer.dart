import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musik_player/models/services/musicHandler.dart';
import 'package:musik_player/views/GenreViewCell.dart';

import '../../models/enums/genre.dart';

class GenreContainer extends StatelessWidget {
  final List<Genre> genres = MusicHandler().allGenres();
   GenreContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("Genres Musicaux", style: GoogleFonts.signika(fontSize: 20),),
          SizedBox(
            height: 75,
            child: ListView.builder(
              itemCount: genres.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) => GenreCell(genre: genres[index]))
            ),
          )
        ],
      ),
    );
  }
}

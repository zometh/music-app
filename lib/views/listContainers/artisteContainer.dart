import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musik_player/models/raw_model/artiste.dart';
import 'package:musik_player/models/services/musicHandler.dart';
import 'package:musik_player/views/artisteCircleCell.dart';

class ArtistContainer extends StatelessWidget {
  const ArtistContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Artist> datas = MusicHandler().allArtists();
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Artistes", style: GoogleFonts.signika(fontSize: 20),),
            ),
            Container(
              height: 90,
              child: ListView.builder(
                itemCount: datas.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) => ArtistCircleCell(artist: datas[index], heigth: 75))

              ),
            )
          ],
        ),
    );
  }
}

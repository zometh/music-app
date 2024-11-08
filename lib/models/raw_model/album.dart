import 'package:musik_player/models/raw_model/artiste.dart';
import 'package:musik_player/models/raw_model/song.dart';

class Album{
  final String title;
  final Artist artiste;
  List<Song> songs;

  Album({required this.title, required this.artiste, required this.songs});
}
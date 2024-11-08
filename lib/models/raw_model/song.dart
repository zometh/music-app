import 'artiste.dart';
import '../enums/genre.dart';
import '../enums/media_type.dart';

class Song {
  final int id;
  final String title;
  final String album;
  final String path;
  final String thumb;
  final Artist artist;
  final Genre genre;
  final MediaType mediaType;

  Song(
      {
      required this.id,
      required this.title,
      required this.album,
      required this.path,
      required this.thumb,
      required this.artist,
      required this.genre,
      required this.mediaType
      });
}

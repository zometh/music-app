import 'package:musik_player/models/services/music_datas.dart';

import '../enums/genre.dart';
import '../raw_model/album.dart';
import '../raw_model/artiste.dart';
import '../raw_model/song.dart';

class MusicHandler{
  final datas = MusicDatas().allDatas();
  List<Artist> allArtists(){
    List<Artist> artists = [];

    for(var song in datas){
      if(!artists.contains(song.artist)){
        artists.add(song.artist);
      }
    }
    return artists;
  }
  List<Album> allAlbums(){
    List<Album> albums = [];
    for(var song in datas){
      final singer = song.artist.name;
      final albumTitle = song.album;
      Album newAlbum = albums.firstWhere((album) => (album.artiste.name == singer), orElse:
          ()=> Album(title: song.album, artiste: song.artist, songs: [song])
      );
      if(!newAlbum.songs.contains(song)) newAlbum.songs.add(song);
      if(!albums.contains(newAlbum)) albums.add(newAlbum);
    }
    return albums;
  }
  List<Genre> allGenres(){
    List<Genre> genres = [];
    for(var song in datas){
      if(!genres.contains(song.genre)) genres.add(song.genre);
    }
    return genres;
  }
  List<Song> allMusicFromArtist(Artist artist){
    List<Song> playList = [];
    for(var song in datas){
      if(song.artist.name == artist.name){
        playList.add(song);
      }
    }
    return playList;
  }

  List<Song> allMusicFromGenre(Genre genre){
    List<Song> playList = [];
    for(var song in datas){
      if(song.genre == genre){
        playList.add(song);
      }
    }
    return playList;
  }
  Song getSong(String string){
    return datas.firstWhere((song) => song.title == string);
  }
  List<Song> research(String string){
    final lowerCase = string.toLowerCase();
    final all = datas;
    List<Song> result = [];
    for(var song in all){
      final artist = song.artist.name.toLowerCase();
      final album = song.album.toLowerCase();
      final title = song.title.toLowerCase();
      if(
      artist.contains(lowerCase) ||
      album.contains(lowerCase) ||
      title.contains(lowerCase)
      ){
        result.add(song);
      }
    }

    return result;
  }
}
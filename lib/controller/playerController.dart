import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musik_player/models/enums/media_type.dart';
import 'package:musik_player/views/playerView.dart';

import '../models/raw_model/song.dart';

class MyPlayerController extends StatefulWidget {
  final Song songToPlay;
  final List<Song> playList;
  const MyPlayerController({super.key, required this.songToPlay, required this.playList});

  @override
  State<MyPlayerController> createState() => _MyPlayerControllerState();
}

class _MyPlayerControllerState extends State<MyPlayerController> {
  late Song song;

  Duration position = const Duration(seconds: 0);
  Duration maxDuration = const Duration(seconds: 0);
  bool shuffle = false;
  bool repeat = false;
  IconData iconData = CupertinoIcons.play_circle;
  late AudioPlayer audioPlayer;
  AudioCache? audioCache;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    song = widget.songToPlay;
    setUpPlayer();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    clearPlayer();
    super.dispose();


  }

  @override
  Widget build(BuildContext context) => PLayerView(song: song, onRepepeatPressed: onRepepeatPressed, onShufflePressed: onShufflePressed, onPlayPausePressed: onPlayPausePressed, onRewindPressses: onRewindPressses, onForwardPressed: onForwardPressed, maxDuration: maxDuration, position: position, onPositionChanged: onPositionChanged, shuffle: shuffle, repeat: repeat, playPause: iconData,);
  onRepepeatPressed(){
      setState(() {
        repeat = !repeat;
      });
  }
  onShufflePressed(){
    setState(() {
      shuffle = !shuffle;
    });
  }
  onPlayPausePressed() async{
      final state = audioPlayer.state;
      switch(state){
        case PlayerState.completed:
          (repeat) ? audioPlayer.seek(Duration(seconds: 0)) : onForwardPressed();
          onForwardPressed();
          break;
        case PlayerState.stopped:
          setUpPlayer();
          break;
        case PlayerState.playing:
          await audioPlayer.pause();
          break;
        case PlayerState.paused:
          await audioPlayer.resume();
          break;
        case PlayerState.disposed:
          // TODO: Handle this case.
      }
  }
  onRewindPressses(){
      final newSong = (shuffle) ? randomSong() : previousSong();
      song = newSong;
      clearPlayer();
      setUpPlayer();
  }
  onForwardPressed(){
    final newSong = (shuffle) ? randomSong() : nextSong();
    song = newSong;
    clearPlayer();
    setUpPlayer();
  }
  onPositionChanged(double newPostion){
    final newDuration = Duration(seconds: newPostion.toInt());
      audioPlayer.seek(newDuration);
  }
  Future<String> pathForInApp() async{
    audioCache = AudioCache();
    String string = "";

    final uri = await audioCache!.load(song.path);
    string = uri.toString();
    return string;
  }
  onStateChanged(PlayerState state){
    setState(() {
      switch (state){
        case PlayerState.playing:
          iconData = CupertinoIcons.pause_circle;
          break;
        case PlayerState.paused:
          iconData = CupertinoIcons.play_circle;
        break;
        case PlayerState.completed:
        break;
        case PlayerState.stopped:
          iconData = CupertinoIcons.play_circle;
          break;
        case PlayerState.disposed:
          // TODO: Handle this case.
      }
    });
  }
  onDurationChanged(Duration duration){
    setState(() {
      maxDuration = duration;
    });
  }
  onPositionChangedd(Duration duration){
    setState(() {
      position = duration;
    });
  }
  setUpPlayer()async{
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen(onStateChanged);
    audioPlayer.onDurationChanged.listen(onDurationChanged);
    audioPlayer.onPositionChanged.listen(onPositionChangedd);
    final url = (song.mediaType == MediaType.internet) ? song.path : await pathForInApp();
    await audioPlayer.play(UrlSource(url));
  }
  clearPlayer(){
    audioPlayer.stop();
    audioPlayer.dispose();
    if(audioCache != null) audioCache?.clearAll();
    audioCache = null;
  }
  Song previousSong(){
    final index = widget.playList.indexWhere((song) => song.title == this.song.title);
    final int newIndex = (index == 0) ? widget.playList.length - 1  : index-1;
    return widget.playList[newIndex];
  }
  Song nextSong(){
    final index = widget.playList.indexWhere((song) => song.title == this.song.title);
    final int newIndex = (index < widget.playList.length - 1) ? index+1  : 0;
    return widget.playList[newIndex];
  }
  Song randomSong(){
    final int index = Random().nextInt(widget.playList.length);
    final newSong = widget.playList[index];
    return newSong;
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musik_player/models/services/musicHandler.dart';
import 'package:musik_player/models/services/sharedHandler.dart';
import 'package:musik_player/views/searchMusicView.dart';

import '../models/raw_model/song.dart';

class SearchControllerz extends StatefulWidget {
   const SearchControllerz({super.key});

  @override
  State<SearchControllerz> createState() => _SearchControllerState();
}

class _SearchControllerState extends State<SearchControllerz> {
  List<String> lastSearchedSongs = [];
  List<Song> searchResults = [];

  late TextEditingController textEditingController;
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    getSharedPref();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Column(
          children: [
            Container(
              height: 75,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: textEditingController,
                        onChanged: search,
                        onSubmitted: save,
                        decoration: const InputDecoration(
                          hintText: "Entrer quelque chose"
                        ),
                      )
                  ),
                  IconButton(
                      onPressed: onPressed,
                      icon: const Icon(Icons.send)
                  )
                ],
              ),
            ),
            Text(
                (textEditingController.text.isEmpty ? "Dernières recherches" : "Nous avons trouver pour vous" ),
              style: GoogleFonts.signika( fontSize: 20),
            ),
            Expanded(
                child: (textEditingController.text.isEmpty) ? emptyWidget(): onSearchWidget(),
            )

          ],
        )
    );
  }
  Widget emptyWidget(){
    return ListView.separated(
        itemBuilder: (context, index){
          final String value = lastSearchedSongs[index];
          return ListTile(
            title: Text(value),
            onTap: (){
              textEditingController.text = value;
              search(value);
            },
            onLongPress: (){
              showDialog(
                barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context){
                    return alertDialog(value);
                  }
              );
            }
            /*(() => remove(value))*/,
          );
        },
        separatorBuilder: ((context, index) => const Divider()),
        itemCount: lastSearchedSongs.length
    );
  }
  Widget onSearchWidget(){
    return ListView.separated(
        itemBuilder: (context, index){
          final song = searchResults[index];
          return SearchMusicView(song: song, playList: searchResults);
        },
        separatorBuilder: ((context,index) => const Divider()),
        itemCount: searchResults.length
    );
  }
  search(String string){
    final result = MusicHandler().research(string);
      setState(() {
        searchResults = result;
      });
  }
  save(String string){
    SharedHandler().addItemToList(string).then((succes) => getSharedPref());
  }
  closeKeyBoard() => FocusScope.of(context).requestFocus(FocusNode());
  onPressed(){
    closeKeyBoard();
    if(textEditingController.text != "") save(textEditingController.text);
    //print(lastSearchedSongs);
  }
  getSharedPref(){
    SharedHandler().getList().then((newList) => {
      setState(() {
        lastSearchedSongs = newList;
      })
    });
  }
  remove(String value){
    SharedHandler().removeItemFromList(value).then((succes) => getSharedPref());
  }
  removeDialog(String item){

  }
   AlertDialog alertDialog(String value){
    var dialog =  AlertDialog(

      icon: const Icon(Icons.restore_from_trash_sharp),
      title:  Text("Voulez vous supprimer cette recherche?", style: GoogleFonts.signika(fontSize: 20),),
      actions: [
        Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Non", style: GoogleFonts.signika(color: Colors.red, fontSize: 20),)),
                ElevatedButton(onPressed: (){
                  remove(value);
                  Navigator.pop(context);
                  showSnack();
                }, child: Text("Oui", style: GoogleFonts.signika(color: Colors.green, fontSize: 20),)),

              ],
            ),
        )
      ],
    );
    return dialog;
  }
  showSnack(){
    final snack = SnackBar(content: Text("Recherche supprimée avec succés",
    style: GoogleFonts.signika(fontSize: 15),
    ));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}

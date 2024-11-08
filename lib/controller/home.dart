import 'package:flutter/material.dart';
import 'package:musik_player/controller/searchController.dart';
import 'package:musik_player/views/music%20view.dart';

import '../models/raw_model/bar_choice.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int current_index = 0;
  List<BarChoice> items = [
    BarChoice(label: "Musique", iconData: Icons.music_note, widget: const MusicView()),
    BarChoice(label: "Favoris", iconData: Icons.whatshot, widget: Container()),
    BarChoice(label: "Recherche", iconData: Icons.search, widget:  const SearchControllerz())
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(10),
              child:  Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Spacer(), 
                      Icon(Icons.radio),
                      Icon(Icons.doorbell),
                      Icon(Icons.settings)
                      
                    ],
                  ),
                  items[current_index].titleForAppBar
                ],
              ),
          )
          )
      ),
      body: items[current_index].widget,
      bottomNavigationBar: BottomNavigationBar(
          items:  items.map((item) => item.item).toList(),
        onTap: barTapped,
        currentIndex: current_index,
      ),
    );
  }
  barTapped(int index){
    setState(() {
      current_index = index;
    });
  }
}

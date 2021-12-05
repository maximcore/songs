import 'package:flutter/material.dart';
import 'package:songs/app/song_card.dart';
import 'package:songs/theme.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AudioPlayer>(
      create: (context) => AudioPlayer(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme(),
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
        child: SongCard(),
      ),
    );
  }
}

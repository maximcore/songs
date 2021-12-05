import 'package:flutter/material.dart';
import 'package:songs/favorite_song_tile.dart';
import 'package:songs/services/spotify_api/song.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';

class FavoriteSongs extends StatelessWidget {
  const FavoriteSongs({
    Key? key,
    required this.favoriteSongs,
  }) : super(key: key);

  final List<Song> favoriteSongs;

  @override
  Widget build(BuildContext context) {
    final AudioPlayer audioPlayer = Provider.of<AudioPlayer>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Favorite Songs',
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: favoriteSongs.length,
            itemBuilder: (context, index) {
              return FavoriteSongItem(
                onImagePressedToPause: () {
                  audioPlayer.pause();
                },
                onImagePressedToPlay: () {
                  audioPlayer.play(
                    favoriteSongs[index].previewUrl,
                    stayAwake: false,
                    isLocal: false,
                  );
                },
                song: Song(
                  artistName: favoriteSongs[index].artistName,
                  songName: favoriteSongs[index].songName,
                  imageUrl: favoriteSongs[index].imageUrl,
                  spotifyUrl: favoriteSongs[index].spotifyUrl,
                  previewUrl: favoriteSongs[index].previewUrl,
                ),
              );
            }),
      ),
    );
  }
}

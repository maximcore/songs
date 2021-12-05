import 'dart:math';

import 'package:flutter/material.dart';
import 'package:songs/app/songs/songs_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:marquee/marquee.dart';
import 'package:songs/app/common_widgets/custom_elevated_button.dart';
import 'package:songs/app/favorite_songs/favorite_songs_page.dart';
import 'package:songs/app/songs/song.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SongCard extends StatefulWidget {
  const SongCard({Key? key}) : super(key: key);

  @override
  _SongCardState createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  final songsHandler = SongsHandler();
  late Song song;
  bool _isLoading = true;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _getSpotifyData();
  }

  void _getSpotifyData() {
    setState(() {
      _isLoading = true;
    });
    songsHandler.spotifyApi
        .fetchAlbum(songsHandler
            .songsIds[Random().nextInt(songsHandler.songsIds.length)])
        .then((value) {
      song = value;
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _horizontalDragEndHandler(DragEndDetails details) {
    setState(() {
      _getSpotifyData();
    });
    if (details.primaryVelocity! > 0) {
      //print('Swipe to the left');
    } else if (details.primaryVelocity! < 0) {
      //print('Swipe to the right');
    }
  }

  Widget _openOnSpotifyButton() {
    return CustomElevatedButton(
      color: Theme.of(context).primaryColor,
      borderRadius: 50,
      height: 50,
      onPressed: () async {
        try {
          await launch(song.spotifyUrl);
        } catch (e) {
          throw 'Could not launch ${song.spotifyUrl}';
        }
      },
      child: const Text('Open on Spotify'),
    );
  }

  Widget _songContainer(BuildContext context, bool isLoading) {
    final AudioPlayer audioPlayer = Provider.of<AudioPlayer>(context);

    final size = MediaQuery.of(context).size;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              GestureDetector(
                onDoubleTap: () {
                  if (!songsHandler.likedSongs.contains(song)) {
                    songsHandler.likedSongs.add(song);
                  }
                },
                child: Image.network(
                  song.imageUrl,
                  height: size.height / 2,
                  width: size.width / 2,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        _isPlaying
                            ? audioPlayer.pause()
                            : audioPlayer.setUrl(song.previewUrl);
                        setState(() {
                          _isPlaying = !_isPlaying;
                        });
                      },
                      icon: _isPlaying
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_arrow)),
                  IconButton(
                    onPressed: () {
                      if (!songsHandler.likedSongs.contains(song)) {
                        songsHandler.likedSongs.add(song);
                      } else {
                        songsHandler.likedSongs.remove(song);
                      }
                      setState(() {});
                    },
                    icon: songsHandler.likedSongs.contains(song)
                        ? const FaIcon(
                            FontAwesomeIcons.heart,
                            color: Colors.red,
                          )
                        : const FaIcon(
                            FontAwesomeIcons.heart,
                            color: Colors.grey,
                          ),
                  ),
                ],
              ),
              Text(
                song.artistName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: size.height / 20,
                width: size.width / 2,
                child: Marquee(
                  text: song.songName,
                  blankSpace: 100,
                  startAfter: const Duration(seconds: 1),
                  velocity: 30,
                  pauseAfterRound: const Duration(seconds: 2),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 80.0, right: 80.0),
                  child: _openOnSpotifyButton()),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: _horizontalDragEndHandler,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          color: Colors.grey[200],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _songContainer(context, _isLoading),
                TextButton(
                  child: const Text('Go to favorites'),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return FavoriteSongs(
                        favoriteSongs: songsHandler.likedSongs,
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

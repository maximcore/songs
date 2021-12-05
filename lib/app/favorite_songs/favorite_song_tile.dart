import 'package:flutter/material.dart';
import 'package:songs/app/songs/song.dart';
import 'package:marquee/marquee.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoriteSongItem extends StatefulWidget {
  const FavoriteSongItem({
    Key? key,
    required this.song,
    required this.onImagePressedToPlay,
    required this.onImagePressedToPause,
  }) : super(key: key);
  final Song song;
  final VoidCallback onImagePressedToPlay;
  final VoidCallback onImagePressedToPause;

  @override
  State<FavoriteSongItem> createState() => _FavoriteSongItemState();
}

class _FavoriteSongItemState extends State<FavoriteSongItem> {
  bool _isSongPlaying = false;

  void _pressed() {
    setState(() {
      _isSongPlaying
          ? widget.onImagePressedToPause()
          : widget.onImagePressedToPlay();
      _isSongPlaying = !_isSongPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                widget.song.imageUrl,
                height: 60,
                width: 60,
              ),
            ),
            Expanded(
              child: Marquee(
                blankSpace: 200,
                startAfter: const Duration(seconds: 1),
                velocity: 30,
                pauseAfterRound: const Duration(seconds: 2),
                text: '${widget.song.artistName} - ${widget.song.songName}',
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              flex: 2,
            ),
            IconButton(
              onPressed: _pressed,
              icon: _isSongPlaying
                  ? const Icon(Icons.pause)
                  : const Icon(Icons.play_arrow),
            ),
            IconButton(
              onPressed: () async {
                await launch(widget.song.spotifyUrl);
              },
              icon: const FaIcon(FontAwesomeIcons.spotify),
            ),
          ],
        ),
      ),
    );
  }
}

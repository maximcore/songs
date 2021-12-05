import 'package:songs/app/songs/song.dart';
import 'package:songs/services/spotify_api/spotify_api.dart';

class SongsHandler {
  final spotifyApi = SpotifyApi();
  final List<String> songsIds = [
    '0UhSorL8bpS84Ag0DZv33s',
    '3ovjw5HZZv43SxTwApooCM',
    '0jakJH5zquY0IsQyjrN4K0',
    '7MjEQlr6TvwGGXgWCbWLkG',
    '6bxulgo5iAC3yK1haIXWhJ',
    '1MqgKYUdKonJbNfQ5NDcwB',
    '7tV9MQNYhgHznk7tTS90Kc',
    '18LhA0zBzAa2YnhcN3hWGa',
    '2DvN8TVLAiEynpTRv0wpeQ',
    '5eDzdiVMg5ccX3loXMImDU',
    '3xl0ddqqqQ0Vnt4vRSyIHj',
    '4obdrS0MedggXXBHehsu9N',
    '5uEYRdEIh9Bo4fpjDd4Na9',
    '2bm9eBd8hXPxEdgizCcEWX',
    '1wm8SCfjMXhHXGtraWwGw9',
    '0ada5XsQGLPUVbmTCkAP49',
    '6i7zAdNhzUN2k1HcrBxPHG',
    '51Of5p3lKZeOg6itfs4og4',
    '3bffZlBH65GZ2rVc9qiHg5',
    '7fddNDOIC20fRULEs0cQbi',
    '6ft4hAq6yde8jPZY2i5zLr',
    '3wB3ViZucTbRoHARLYWfoB',
    '4yNoUQkYf1QF8iYlEzNynH',
  ];

  final List<Song> likedSongs = [];
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:songs/app/songs/song.dart';

class SpotifyApi {
  static const baseUrl = 'https://api.spotify.com/v1';

  // TODO: Replace to new token if expires
  final String _oAuthToken =
      'BQDqdOwiQz35yoQSdYOvfFnY_kbmhQCiKzZPrqE0FJviutkvwlQZP_-73AgVEBN5EwTTQpEU84cIA2LIHjExzuSVBwzvfK2ZIx4PNM35VX0qV9xHjM9AyYC4P6sAXAfVQ_3s5LONwxKZFO8sKDXASTIuU6SdIBglJnOIBQCEkFo2tnj1UhldI49Z7sZUfc24VrW7fg';

  Future<Song> fetchAlbum(String id) async {
    final trackUrl = Uri.parse('$baseUrl/tracks/$id');
    final trackResponse = await http.get(trackUrl, headers: {
      'Authorization': 'Bearer $_oAuthToken',
    });
    final trackInfo = json.decode(trackResponse.body);
    return Song.fromJson(trackInfo);
  }
}

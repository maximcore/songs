import 'package:flutter/material.dart';

class Song {
  Song({
    required this.artistName,
    required this.songName,
    required this.imageUrl,
    required this.spotifyUrl,
    required this.previewUrl,
  });
  final String artistName;
  final String songName;
  final String imageUrl;
  final String spotifyUrl;
  final String previewUrl;

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      artistName: json['album']['artists'][0]['name'] as String,
      songName: json['name'] as String,
      imageUrl: json['album']['images'][0]['url'] as String,
      spotifyUrl: json['external_urls']['spotify'] as String,
      previewUrl: json['preview_url'] as String,
    );
  }

  @override
  String toString() {
    return '''Artist name: $artistName, Song name: $songName, Image url: $imageUrl, Spotify url: $spotifyUrl, Preview url: $previewUrl     
    ''';
  }

  @override
  int get hashCode =>
      hashValues(artistName, songName, imageUrl, spotifyUrl, previewUrl);

  @override
  bool operator ==(other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    final Song otherSong = other as Song;
    return artistName == otherSong.artistName &&
        songName == otherSong.songName &&
        imageUrl == otherSong.imageUrl &&
        spotifyUrl == otherSong.spotifyUrl &&
        previewUrl == otherSong.previewUrl;
  }
}

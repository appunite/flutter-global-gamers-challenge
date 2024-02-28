const List<Song> songs = [
  Song('background.mp3', 'Kids Games (Adventure Games) Background', artist: 'Rowneypeters'),
];

class Song {
  final String filename;

  final String name;

  final String? artist;

  const Song(this.filename, this.name, {this.artist});

  @override
  String toString() => 'Song<$filename>';
}

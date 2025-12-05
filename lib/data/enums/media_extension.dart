enum MediaExtension {
  mp3('MP3'),
  mp4('MP4');

  const MediaExtension(this.extension);
  final String extension;

  static MediaExtension fromValue(String value) {
    return MediaExtension.values
        .firstWhere((element) => element.extension == value);
  }
}

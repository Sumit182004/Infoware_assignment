abstract class AudioPlayerState {}

class AudioPlayerInitial extends AudioPlayerState {}

class AudioPlayerPlaying extends AudioPlayerState {
  final String url;
  AudioPlayerPlaying(this.url);
}

class AudioPlayerPaused extends AudioPlayerState {}

class AudioPlayerStopped extends AudioPlayerState {}

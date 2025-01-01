abstract class AudioPlayerEvent {}

class PlayAudioEvent extends AudioPlayerEvent {
  final String url;
  PlayAudioEvent(this.url);
}

class PauseAudioEvent extends AudioPlayerEvent {}

class StopAudioEvent extends AudioPlayerEvent {}

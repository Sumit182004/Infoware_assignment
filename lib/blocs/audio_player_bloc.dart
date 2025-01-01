import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_assignment/audio_player_event.dart';
import 'package:internship_assignment/audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayerBloc() : super(AudioPlayerInitial()) {
    on<PlayAudioEvent>((event, emit) async {
      // Check if the event.url is a URL or an asset and handle accordingly
      if (event.url.startsWith('http')) {
        await _audioPlayer.play(UrlSource(event.url));  // Play from URL
      } else {
        await _audioPlayer.play(AssetSource(event.url));  // Play from Asset
      }
      emit(AudioPlayerPlaying(event.url));
    });

    on<PauseAudioEvent>((event, emit) async {
      await _audioPlayer.pause();
      emit(AudioPlayerPaused());
    });

    on<StopAudioEvent>((event, emit) async {
      await _audioPlayer.stop();
      emit(AudioPlayerStopped());
    });
  }
}

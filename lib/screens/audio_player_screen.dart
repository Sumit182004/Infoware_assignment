import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_assignment/audio_player_event.dart';
import 'package:internship_assignment/audio_player_state.dart';
import 'package:internship_assignment/blocs/audio_player_bloc.dart';


class AudioPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioPlayerBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text('Audio Player')),
        body: BlocConsumer<AudioPlayerBloc, AudioPlayerState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is AudioPlayerInitial) ...[
                    Text('Press Play to Start'),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AudioPlayerBloc>().add(
                          PlayAudioEvent('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'),
                        );
                      },
                      child: Text('Play'),
                    ),
                  ] else if (state is AudioPlayerPlaying) ...[
                    Text('Playing: ${state.url}'),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AudioPlayerBloc>().add(PauseAudioEvent());
                      },
                      child: Text('Pause'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AudioPlayerBloc>().add(StopAudioEvent());
                      },
                      child: Text('Stop'),
                    ),
                  ] else if (state is AudioPlayerPaused) ...[
                    Text('Audio Paused'),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AudioPlayerBloc>().add(PauseAudioEvent());
                      },
                      child: Text('Resume'),
                    ),
                  ] else if (state is AudioPlayerStopped) ...[
                    Text('Audio Stopped'),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AudioPlayerBloc>().add(PlayAudioEvent('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'));
                      },
                      child: Text('Play Again'),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

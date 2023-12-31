import 'package:flutter/material.dart';
import 'package:music_player/src/models/audio_player_model.dart';
import 'package:music_player/src/pages/music_player.dart';
import 'package:music_player/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return AudioPlayerModel();
        }),
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: miTema,
        debugShowCheckedModeBanner: false,
        home: MusicPlayerPage(),
      ),
    );
  }
}

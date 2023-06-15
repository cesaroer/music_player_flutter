import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/src/helpers/helpers.dart';
import 'package:music_player/src/models/audio_player_model.dart';
import 'package:music_player/src/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Column(
            children: [
              CustomAppBar(),
              ImagenDiscoYDuracion(),
              TitlePlay(),
              Expanded(
                child: Lyrics(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.center,
          colors: [
            Color(0xff333333e),
            Color(0xff201e28),
          ],
        ),
      ),
    );
  }
}

class Lyrics extends StatelessWidget {
  final lyrics = getLyrics();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListWheelScrollView(
        physics: const BouncingScrollPhysics(),
        itemExtent: 42,
        children: lyrics
            .map((e) => Text(e,
                style: TextStyle(
                    fontSize: 20, color: Colors.white.withOpacity(0.6))))
            .toList(),
        diameterRatio: 1.5,
      ),
    );
  }
}

class TitlePlay extends StatefulWidget {
  @override
  State<TitlePlay> createState() => _TitlePlayState();
}

class _TitlePlayState extends State<TitlePlay>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  bool firstTime = true;
  late AnimationController controller;
  final assetAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  void open() {
    final audioPlayerModel =
        Provider.of<AudioPlayerModel>(context, listen: false);

    assetAudioPlayer.open(Audio('assets/Breaking-Benjamin-Far-Away.mp3'),
        autoStart: true, showNotification: true);

    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayerModel.current = duration;
    });

    assetAudioPlayer.current.listen((playingAudio) {
      audioPlayerModel.songDuration =
          playingAudio?.audio.duration ?? Duration(seconds: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      margin: const EdgeInsets.only(top: 40),
      child: Row(
        children: [
          Column(
            children: [
              Text("Far Away",
                  style: TextStyle(
                      fontSize: 30, color: Colors.white.withOpacity(0.8))),
              Text("Breaking Benjamin",
                  style: TextStyle(
                      fontSize: 15, color: Colors.white.withOpacity(0.5))),
            ],
          ),
          const Spacer(),
          FloatingActionButton(
            elevation: 0,
            onPressed: () {
              final audioPlayermodel =
                  Provider.of<AudioPlayerModel>(context, listen: false);

              if (this.isPlaying) {
                controller.reverse();
                this.isPlaying = false;
                audioPlayermodel.controller.stop();
              } else {
                this.isPlaying = true;
                controller.forward();
                audioPlayermodel.controller.repeat();
              }

              if (firstTime) {
                this.open();
                firstTime = false;
              } else {
                assetAudioPlayer.playOrPause();
              }
            },
            backgroundColor: Color(0xfff8cb51),
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: controller,
            ),
          )
        ],
      ),
    );
  }
}

class ImagenDiscoYDuracion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.only(top: 70),
      child: Row(
        children: [
          ImagenDisco(),
          SizedBox(width: 20),
          BarraProgreso(),
          SizedBox(width: 20)

          //
        ],
      ),
    );
  }
}

class BarraProgreso extends StatelessWidget {
  final style = TextStyle(color: Colors.white.withOpacity(0.4));

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    final porcentaje = audioPlayerModel.porcentajeSong;

    return Container(
      child: Column(
        children: [
          Text("${audioPlayerModel.songTotalDuration}", style: style),
          SizedBox(height: 10),
          Stack(
            children: [
              Container(
                width: 3,
                height: 230,
                color: Colors.white.withOpacity(0.1),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 3,
                  height: 230 * porcentaje,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text("${audioPlayerModel.currentSecond}", style: style),
        ],
      ),
    );
  }
}

class ImagenDisco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioPlayermodel = Provider.of<AudioPlayerModel>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      width: 250,
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SpinPerfect(
              animate: false,
              manualTrigger: true,
              controller: (animationcontroller) =>
                  audioPlayermodel.controller = animationcontroller,
              infinite: true,
              duration: Duration(seconds: 10),
              child: Image(
                image: AssetImage('assets/aurora.jpg'),
              ),
            ),
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Color(0xff1c1c25),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          colors: [Color(0xff484750), Color(0xff1e1c24)],
        ),
      ),
    );
  }
}

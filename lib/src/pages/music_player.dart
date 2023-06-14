import 'package:flutter/material.dart';
import 'package:music_player/src/widgets/custom_appbar.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [CustomAppBar(), ImagenDiscoYDuracion(), TitlePlay()],
      ),
    );
  }
}

class TitlePlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      margin: EdgeInsets.only(top: 40),
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
          Spacer(),
          FloatingActionButton(
            elevation: 0,
            onPressed: () {},
            backgroundColor: Color(0xfff8cb51),
            child: Icon(Icons.play_arrow),
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
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 70),
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
    return Container(
      child: Column(
        children: [
          Text("0:00", style: style),
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
                  height: 100,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text("0:00", style: style),
        ],
      ),
    );
  }
}

class ImagenDisco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: 250,
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(image: AssetImage('assets/aurora.jpg')),
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

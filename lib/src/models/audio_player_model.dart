import 'package:flutter/material.dart';

class AudioPlayerModel with ChangeNotifier {
  bool _playing = false;

  late AnimationController _controller;

  set controller(AnimationController c) {
    this._controller = c;
  }

  AnimationController get controller => this._controller;

  set playing(bool v) {
    this._playing = v;
  }
}

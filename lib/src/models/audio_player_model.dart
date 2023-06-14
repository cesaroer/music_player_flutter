import 'package:flutter/material.dart';

class AudioPlayerModel with ChangeNotifier {
  bool _playing = false;
  Duration _songDuration = Duration(milliseconds: 0);
  Duration _current = Duration(milliseconds: 0);

  String get songTotalDuration => this.printDuration(_songDuration);
  String get currentSecond => this.printDuration(_current);

  double get porcentajeSong => (_songDuration.inSeconds < 0)
      ? this._current.inSeconds / this._songDuration.inSeconds
      : 0;

  late AnimationController _controller;

  set controller(AnimationController c) {
    this._controller = c;
  }

  AnimationController get controller => this._controller;

  set playing(bool v) {
    this._playing = v;
    notifyListeners();
  }

  set songDuration(Duration v) {
    this._songDuration = v;
    notifyListeners();
  }

  set current(Duration v) {
    this._current = v;
    notifyListeners();
  }

  bool get playing => this._playing;

  Duration get songDuration => this._songDuration;

  Duration get current => this._current;

  String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

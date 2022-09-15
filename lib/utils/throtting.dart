import 'dart:async';

import 'package:flutter/material.dart';

class Throttle {
  final int milliseconds;

  Throttle({
    this.milliseconds = 1000,
  });

  Timer? _timer;

  void run(VoidCallback action) {
    if (_timer != null) {
      return;
    }
    action();
    _timer = Timer(Duration(milliseconds: this.milliseconds), () async {
      await Future.delayed(
        Duration(milliseconds: this.milliseconds),
        _timer = null,
      );
    });
  }
}

class Debounce {
  final int milliseconds;

  Debounce({
    this.milliseconds = 500,
  });

  Timer? _timer;

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: this.milliseconds), action);
  }
}

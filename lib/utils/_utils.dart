// ignore_for_file: avoid_app, non_constant_identifier_names

import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart' show PlatformDispatcher;
import 'package:flutter/material.dart';

///
///

bool isPhone = false;
Random _random = Random();
//
bool setDeviceType() {
  Size size = PlatformDispatcher.instance.views.first.physicalSize;
  final pixelRatio =
      PlatformDispatcher.instance.views.first.display.devicePixelRatio;

  final height = size.height / pixelRatio;
  final width = size.width / pixelRatio;
  final isPortrait = height > width;
  //z

  if (isPortrait) {
    isPhone = !(width > 510);
  } else {
    isPhone = !(height > 510);
  }
  app("device height $height and width $width isPhone $isPhone");
  return isPhone;
}

bool get isDark {
  return PlatformDispatcher.instance.platformBrightness == Brightness.dark;
}

bool get isLight => !isDark;

void app(Object? object) {
  debugPrint(object.toString());
}

Future<void> WaitFor(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}

String get timeStamp => DateTime.now().millisecondsSinceEpoch.toString();
String get now => DateTime.now().toString();
int random(int max) => _random.nextInt(max);

Future throwTimeoutExceptionAfter(int milliseconds) {
  return Future.delayed(Duration(milliseconds: milliseconds), () {
    throw TimeoutException(
        "Failed to receive response within $milliseconds milliseconds");
  });
}

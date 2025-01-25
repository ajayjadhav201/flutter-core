part of '_styles.dart';

BoxDecoration blueWhiteGradientDecoration = BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomCenter,
  stops: [0, 0.20, 0.50, 0.70, 1],
  colors: [
    //
    Colors.blue.shade100,
    Colors.blue.shade200,
    Colors.blue.shade300,
    Colors.blue.shade200,
    Colors.blue.shade100,
  ],
));

BoxDecoration redWhiteGradientDecoration = BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomCenter,
  stops: [0, 0.5, 0.85, 1],
  colors: [
    //
    Colors.red.shade50,
    Colors.red.shade100,
    Colors.white,
    Colors.blue.shade50,
  ],
));

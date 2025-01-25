// ignore_for_file: annotate_overrides

part of '_theme.dart';

class Light extends AppTheme {
  bool isDark = false;
  Color backgroundColor = AppColor(242, 242, 247);
  Color primaryColor = AppColor(255, 255, 255);
  //
  Color textColor = Colors.black;
}

class NaturalTheme extends Light {
  Color backgroundColor = const AppColor(255, 232, 233);
  Color primaryColor = const AppColor(255, 242, 242);
}

class Light1 extends Light {
  Color backgroundColor = const AppColor(247, 242, 237);
  Color primaryColor = Colors.white;
  Color secondaryColor = AppColor(237, 231, 228);
  Color tertiaryColor = AppColor(215, 195, 235);
}

class LightPink extends Light {
  Color backgroundColor = AppColor(252, 237, 242);
  Color primaryColor = AppColor(245, 223, 233);
  Color secondaryColor = Colors.white;
}

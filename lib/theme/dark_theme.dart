part of '_theme.dart';

//
// DARK
class Dark extends AppTheme {
  bool isDark = true;
  Color backgroundColor = AppColor(0, 0, 0);
  Color primaryColor = AppColor(28, 28, 30);
  //
  Color textColor = Colors.white;
}

class DarkBlue1 extends Dark {
  Color backgroundColor = AppColor(45, 59, 84);
  Color primaryColor = AppColor(36, 66, 112);
  Color secondaryColor = Colors.white;
}

class DarkBlue extends Dark {
  Color backgroundColor = AppColor(16, 17, 22);
  Color primaryColor = AppColor(29, 33, 42);
}

part of '_theme.dart';

sealed class AppTheme with AppThemeMode {
  @override
  bool get isDark;
  Color get backgroundColor;
  Color get primaryColor;
  Color get textColor;
}

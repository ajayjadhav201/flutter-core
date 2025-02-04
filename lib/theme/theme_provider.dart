// ignore: must_be_immutable
part of '_theme.dart';

class ThemeProvider<Theme extends AppThemeMode> extends StatelessWidget {
  ThemeProvider({
    super.key,
    required this.theme,
    required this.supportedThemes,
    required this.child,
  });
  final Widget child;
  final Theme theme;

  final List<Theme> supportedThemes;

  // ignore: library_private_types_in_public_api
  static _ThemeProvider of(BuildContext context) =>
      InheritedScope.read<_ThemeProvider>(context);

  late final widget = InheritedScope(
      value: _ThemeProvider(theme, supportedThemes), child: child);

  @override
  Widget build(BuildContext context) {
    return widget;
  }
  //
  //
}

class _ThemeProvider<T extends AppThemeMode> extends ChangeNotifier {
  T theme;
  Type _currentThemeType;
  // ignore: prefer_final_fields
  List<T> _supportedThemes;

  _ThemeProvider(this.theme, List<T> supportedThemes)
      : _currentThemeType = theme.runtimeType,
        _supportedThemes = supportedThemes;
  //
  bool get isDark => theme.isDark;

  setTheme<Theme>() {
    if (Theme == _currentThemeType) return;
    theme = _supportedThemes.firstWhere((e) => e.runtimeType == Theme);
    _currentThemeType = theme.runtimeType;
    notifyListeners();
  }
  //
}

extension ThemeExtension on BuildContext {
  MyTheme get theme =>
      InheritedScope.watch<_ThemeProvider<MyTheme>>(this).theme;
}

//
//
mixin AppThemeMode {
  bool get isDark;
}

class MyTheme with AppThemeMode {
  //
  bool isDark = false;
}

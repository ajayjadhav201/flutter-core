import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter extends GoRouter {
  //
  static AppRouter? _router;
  //
  factory AppRouter({
    required List<AppRoute> routes,
    GoExceptionHandler? onException,
    GoRouterPageBuilder? errorPageBuilder,
    GoRouterWidgetBuilder? errorBuilder,
    GoRouterRedirect? redirect,
    Listenable? refreshListenable,
    int redirectLimit = 5,
    bool routerNeglect = false,
    String? initialLocation,
    bool overridePlatformDefaultLocation = false,
    Object? initialExtra,
    List<NavigatorObserver>? observers,
    bool debugLogDiagnostics = false,
    GlobalKey<NavigatorState>? navigatorKey,
    String? restorationScopeId,
    bool requestFocus = true,
  }) {
    _router ??= AppRouter.routingConfig(
      routingConfig: _ConstantRoutingConfig(
        RoutingConfig(
          routes: routes,
          redirect: redirect ?? (_, __) => null,
          redirectLimit: redirectLimit,
        ),
      ),
    );
    //
    return _router!;
  }
  //
  AppRouter.routingConfig({
    required super.routingConfig,
    super.extraCodec,
    super.onException,
    super.errorPageBuilder,
    super.errorBuilder,
    super.refreshListenable,
    super.routerNeglect,
    super.initialLocation,
    super.initialExtra,
    super.observers,
    super.debugLogDiagnostics,
    super.navigatorKey,
    super.restorationScopeId,
    super.requestFocus,
  }) : super.routingConfig();
  //
  //
  // NAVIGATION METHODS
  static void popRoute() {
    _router?.pop();
  }

  static goTo(AppRoute route) {
    _router?.goNamed(route.name!);
  }

  static pushTo(AppRoute route) {
    _router?.pushNamed(route.name!);
  }

  static pushReplacementTo(AppRoute route) {
    _router?.pushReplacementNamed(route.name!);
  }
  //
  //
}

///
///
///
class AppRoute extends GoRoute {
  //
  AppRoute({
    required super.path,
    required String name,
    this.routes = const <AppRoute>[],
    super.builder,
    super.pageBuilder,
    super.parentNavigatorKey,
    super.redirect,
    super.onExit,
    //
  })  : assert(name.isNotEmpty, "AppRoute name should not be empty"),
        super(routes: routes, name: name);
  //

  final List<AppRoute> routes;
}

///
///
///
class _ConstantRoutingConfig extends ValueListenable<RoutingConfig> {
  const _ConstantRoutingConfig(this.value);
  @override
  void addListener(VoidCallback listener) {
    // Intentionally empty because listener will never be called.
  }

  @override
  void removeListener(VoidCallback listener) {
    // Intentionally empty because listener will never be called.
  }

  @override
  final RoutingConfig value;
}

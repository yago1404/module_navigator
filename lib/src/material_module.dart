import 'package:flutter/material.dart';
import 'package:module_navigator/module_navigator.dart';
import 'package:module_navigator/src/route_provider.dart';
import 'package:provider/provider.dart';

class MaterialModule extends StatelessWidget {
  final String initialRoute;
  final String? title;
  final List<Module> modules;
  final ThemeData themeData;
  final List<NavigatorObserver>? navigatorObservers;

  const MaterialModule({
    super.key,
    required this.initialRoute,
    required this.modules,
    required this.themeData,
    this.title,
    this.navigatorObservers,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _initBinds(),
      child: MaterialApp(
        title: title ?? '',
        navigatorObservers: [
          CustomNavigatorObserver(),
          ...navigatorObservers ?? [],
        ],
        theme: themeData,
        initialRoute: initialRoute,
        routes: _initRoutes(),
      ),
    );
  }

  Map<String, Widget Function(BuildContext context)> _initRoutes() {
    final Map<String, Widget Function(BuildContext context)> routes = {};
    for (Module module in modules) {
      _extractRoutesFromModules(module, routes);
    }
    return routes;
  }

  void _extractRoutesFromModules(
    Module module,
    Map<String, Widget Function(BuildContext context)> routes, {
    String? prefix,
  }) {
    String baseRoute = '${prefix ?? ''}${module.moduleRoute}'.trim();
    debugPrint('LoadRoute: $baseRoute');
    routes[baseRoute] = (_) => module.initialPage;
    for (String route in module.routes.keys) {
      if (module.routes[route] is Module) {
        _extractRoutesFromModules(module.routes[route], routes, prefix: '${prefix ?? ' '}${module.moduleRoute}');
        continue;
      }
      routes['${module.moduleRoute}$route'] = (_) => module.routes[route]!;
    }
  }

  List<Provider> _initBinds() {
    List<Provider> providersInstances = [
      Provider(create: (_) => RouteProvider()),
    ];
    List<Provider> createdProviders = [];
    for (Module module in modules) {
      for (Provider singleton in module.moduleBinds) {
        if (createdProviders.contains(singleton)) {
          continue;
        }
        providersInstances.add(singleton);
        createdProviders.add(singleton);
      }
    }
    return providersInstances;
  }
}

class CustomNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint(
        'Navigator push: ${previousRoute?.settings.name} ------> ${route.settings.name}');
    super.didPush(route, previousRoute);
  }
  
  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    debugPrint(
        'Navigator pushReplacement: ${oldRoute?.settings.name} ------> ${newRoute?.settings.name}');
    super.didReplace();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
        'Navigator Remove: ${previousRoute?.settings.name} ------> ${route.settings.name}');
    super.didRemove(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint(
        'Navigator pop: ${route.settings.name} ------> ${previousRoute?.settings.name}');
    super.didPop(route, previousRoute);
  }
}
